{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../bundles/base.nix
    ../../bundles/desktop.nix
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
