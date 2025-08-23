# Desktop profile configuration
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../bundles/base.nix                # Essential system bundle
    ../../bundles/desktop.nix             # Desktop environment bundle
    inputs.home-manager.nixosModules.default
    ../../modules/docker/docker.nix       # Docker for development
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
