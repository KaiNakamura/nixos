{ config, pkgs, inputs, ... }:

{
  imports = [
    ../modules/secrets/secrets.nix
  ];

  # Additional packages for homelab server management
  environment.systemPackages = with pkgs; [
    kubectl  # Kubernetes CLI
    helm     # Helm package manager
    git      # Version control (for GitOps)
  ];
}
