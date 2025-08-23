# Homelab profile configuration
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../bundles/base.nix                # Essential system bundle
    ../../bundles/server.nix              # Server essentials bundle
    inputs.home-manager.nixosModules.default
    ../../modules/docker/docker.nix       # Docker for Kubernetes
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # Hostname will be set by flake
  networking.hostName = "PLACEHOLDER";
}
