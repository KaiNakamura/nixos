{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../base/base.nix
    ../../base/server.nix
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
