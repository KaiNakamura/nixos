{ config, lib, pkgs, ... }:

let
  cfg = config.homelab.k3s;
  
  # Kubernetes manifests for kubectl access on agent nodes
  # These create the necessary service account and permissions for kubectl to work
  kubectlServiceAccountManifest = pkgs.writeText "kubectl-service-account.yaml" ''
    ---
    # Service Account for kubectl access
    # This creates a dedicated service account that can be used for kubectl operations
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: kubectl-user
      namespace: default
    
    ---
    # Secret for the service account token
    # In Kubernetes 1.24+, service account tokens are not automatically created
    # so we need to explicitly create a secret to hold the token
    apiVersion: v1
    kind: Secret
    metadata:
      name: kubectl-user-token
      namespace: default
      annotations:
        kubernetes.io/service-account.name: kubectl-user
    type: kubernetes.io/service-account-token
    
    ---
    # ClusterRoleBinding to grant cluster-admin permissions
    # This gives the service account full cluster access (similar to kubectl on server)
    # For production, you might want to use a more restrictive role
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: kubectl-user-binding
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: cluster-admin
    subjects:
    - kind: ServiceAccount
      name: kubectl-user
      namespace: default
  '';

in {
  config = lib.mkIf (cfg.role == "server") {
    # Systemd service to apply kubectl service account manifests
    # This runs once after K3s is ready to create the necessary RBAC resources
    systemd.services.k3s-kubectl-setup = {
      description = "Setup kubectl service account for agent nodes";
      after = [ "k3s.service" ];
      wants = [ "k3s.service" ];
      wantedBy = [ "multi-user.target" ];
      
      # Only run once - if the service account already exists, kubectl apply will be idempotent
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        # Wait for K3s API server to be ready before applying manifests
        ExecStartPre = "${pkgs.bash}/bin/bash -c 'until ${pkgs.curl}/bin/curl -k -s https://localhost:6443/healthz >/dev/null 2>&1; do sleep 2; done'";
        ExecStart = "${pkgs.kubectl}/bin/kubectl apply -f ${kubectlServiceAccountManifest}";
        # Set KUBECONFIG for this service to use the server's kubeconfig
        Environment = "KUBECONFIG=/etc/rancher/k3s/k3s.yaml";
      };
      
      # Restart if the service fails (network issues, etc.)
      restartIfChanged = true;
    };

    # Systemd service to extract service account token and update SOPS secret
    # This extracts the token from Kubernetes and provides instructions for updating SOPS
    systemd.services.k3s-token-extract = {
      description = "Extract kubectl service account token for SOPS";
      after = [ "k3s-kubectl-setup.service" ];
      wants = [ "k3s-kubectl-setup.service" ];
      # Don't auto-start this service - it's meant to be run manually when needed
      # wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Environment = "KUBECONFIG=/etc/rancher/k3s/k3s.yaml";
        # Extract the token and provide instructions
        ExecStart = pkgs.writeShellScript "extract-kubectl-token" ''
          set -e
          
          echo "Extracting kubectl service account token..."
          
          # Wait for secret to be populated with token
          echo "Waiting for service account token to be created..."
          timeout=60
          while [ $timeout -gt 0 ]; do
            if ${pkgs.kubectl}/bin/kubectl get secret kubectl-user-token -o jsonpath='{.data.token}' 2>/dev/null | base64 -d | head -c 10 >/dev/null 2>&1; then
              break
            fi
            sleep 2
            timeout=$((timeout - 2))
          done
          
          if [ $timeout -le 0 ]; then
            echo "ERROR: Service account token was not created within 60 seconds"
            exit 1
          fi
          
          # Extract the actual token
          TOKEN=$(${pkgs.kubectl}/bin/kubectl get secret kubectl-user-token -o jsonpath='{.data.token}' | base64 -d)
          
          echo "========================================="
          echo "kubectl Service Account Token extracted!"
          echo "========================================="
          echo
          echo "To update your SOPS secrets, run these commands:"
          echo
          echo "1. Edit the secrets file:"
          echo "   sops ~/repos/nixos/secrets.yaml"
          echo
          echo "2. Add or update the kubectl token:"
          echo "   k3s:"
          echo "     kubectl-token: |"
          echo "       $TOKEN"
          echo
          echo "3. Rebuild your systems:"
          echo "   sudo nixos-rebuild switch --flake /etc/nixos#homelab-00"
          echo "   sudo nixos-rebuild switch --flake /etc/nixos#homelab-01"
          echo
          echo "4. Test kubectl on agent node (homelab-01):"
          echo "   kubectl get nodes"
          echo
          echo "========================================="
          
          # Also save token to a temporary file for easy copying
          echo "$TOKEN" > /tmp/kubectl-token.txt
          chmod 600 /tmp/kubectl-token.txt
          echo "Token also saved to /tmp/kubectl-token.txt for easy copying"
        '';
      };
    };
  };
}
