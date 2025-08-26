{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../../base/base.nix
    ../../base/desktop.nix # TODO: Likely remove in the future
    ../../base/server.nix
    ../modules/tailscale/tailscale.nix
    ../../modules/k3s/k3s.nix
    inputs.home-manager.nixosModules.default
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };
}
