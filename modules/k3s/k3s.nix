{ config, pkgs, lib, role ? "agent", ... }:

{
  # Enable K3s service with role-based configuration
  services.k3s = {
    enable = true;
    role = role;
    
    # Common configuration for both server and agent
    extraFlags = lib.optionals (role == "server") [
      "--disable=traefik"  # We'll manage our own Traefik via GitOps
      "--write-kubeconfig-mode=644"  # Make kubeconfig readable
    ] ++ lib.optionals (role == "agent") [
      "--server=https://100.64.0.1:6443"  # TODO: Replace with actual Tailscale IP
    ];
    
    # Token file for cluster authentication (managed by SOPS)
    tokenFile = config.sops.secrets."k3s/token".path;
  };

  environment.shellAliases = {
    "k" = "kubectl";
  };

  # Configure SOPS secret for K3s token
  sops.secrets."k3s/token" = {
    sopsFile = ../../../secrets.yaml;
  };

  # Install Kubernetes management tools on all nodes
  environment.systemPackages = with pkgs; [
    kubectl  # Kubernetes CLI tool
    helm  # Helm package manager for Kubernetes
  ];

  # Firewall configuration based on K3s networking requirements
  # Source: https://docs.k3s.io/installation/requirements#networking
  networking.firewall = {
    allowedTCPPorts = lib.optionals (role == "server") [
      10250  # Kubelet metrics
      6443  # K3s supervisor and Kubernetes API server
      2379  # etcd client requests (server only) 
      2380  # etcd peer communication (server only)
    ] ++ lib.optionals (role == "agent") [
      10250  # Kubelet metrics
    ];
    
    allowedUDPPorts = [
      8472  # Flannel VXLAN (default CNI for K3s)
    ];
  };

  # Set KUBECONFIG environment variable for server nodes
  # Source: https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/
  environment.variables = lib.mkIf (role == "server") {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  # Service dependencies - ensure Tailscale is running before K3s
  systemd.services = {
    k3s = lib.mkIf (role == "agent") {
      after = [ "tailscaled.service" ];
      wants = [ "tailscaled.service" ];
    };
    
    k3s-server = lib.mkIf (role == "server") {
      after = [ "tailscaled.service" ];
      wants = [ "tailscaled.service" ];
    };
  };
}
