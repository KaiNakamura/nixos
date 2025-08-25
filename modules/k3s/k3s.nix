{ config, pkgs, lib, ... }:

{
  # Define homelab-specific options
  options.homelab = {
    k3s = {
      role = lib.mkOption {
        type = lib.types.enum [ "server" "agent" ];
        default = "agent";
        description = "K3s cluster role - either server or agent";
      };
      
      serverHostname = lib.mkOption {
        type = lib.types.str;
        default = "homelab-00";
        description = "Hostname of the K3s server for agents to connect to (uses Tailscale MagicDNS)";
      };
    };
  };

  # Configuration based on the options
  config = let
    cfg = config.homelab.k3s;
  in {
    # Enable K3s service with role-based configuration
    services.k3s = {
      enable = true;
      role = cfg.role;
      
      # Common configuration for both server and agent
      extraFlags = lib.optionals (cfg.role == "server") [
        "--disable=traefik"  # We'll manage our own Traefik via GitOps
        "--write-kubeconfig-mode=644"  # Make kubeconfig readable
      ] ++ lib.optionals (cfg.role == "agent") [
        "--server=https://${cfg.serverHostname}:6443"  # Use Tailscale MagicDNS hostname
      ];
      
      # Token file for cluster authentication (managed by SOPS)
      tokenFile = config.sops.secrets."k3s/token".path;
    };

    # Use K3s built-in kubectl
    # TODO: Maybe change to just kubectl? Not sure
    environment.shellAliases = {
      "k" = "k3s kubectl";
    };

    # Set KUBECONFIG only on server
    environment.variables = lib.mkIf (cfg.role == "server") {
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };

    # Configure SOPS secret for K3s token
    # WARNING: Changing this token requires cluster reinitialization
    # See: https://docs.k3s.io/datastore#datastore-endpoint-format-and-functionality
    sops.secrets."k3s/token" = {
      sopsFile = ../../secrets.yaml;
      # Restart K3s when token changes
      restartUnits = [ "k3s.service" ];
    };

    # Install Kubernetes management tools only on server
    environment.systemPackages = lib.optionals (cfg.role == "server") (with pkgs; [
      kubectl  # Kubernetes CLI tool
      helm  # Helm package manager for Kubernetes
      k9s  # Kubernetes TUI
    ]);

    # Firewall configuration based on K3s networking requirements
    # Source: https://docs.k3s.io/installation/requirements#networking
    networking.firewall = {
      allowedTCPPorts = lib.optionals (cfg.role == "server") [
        10250  # Kubelet metrics
        6443  # K3s supervisor and Kubernetes API server
        2379  # etcd client requests (server only) 
        2380  # etcd peer communication (server only)
      ] ++ lib.optionals (cfg.role == "agent") [
        10250  # Kubelet metrics
      ];
      
      allowedUDPPorts = [
        8472  # Flannel VXLAN (default CNI for K3s)
      ];
    };

    # Service dependencies - ensure Tailscale is running before K3s
    systemd.services = {
      k3s = lib.mkIf (cfg.role == "agent") {
        after = [ "tailscaled.service" ];
        wants = [ "tailscaled.service" ];
      };
      
      k3s-server = lib.mkIf (cfg.role == "server") {
        after = [ "tailscaled.service" ];
        wants = [ "tailscaled.service" ];
      };
    };
  };
}
