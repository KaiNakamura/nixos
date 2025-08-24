{ config, pkgs, inputs, lib, role ? "agent", ... }:

{
  imports = [
    ../../base/base.nix
    ../../base/desktop.nix # TODO: Likely remove in the future
    ../../base/server.nix
    ../../modules/secrets/secrets.nix
    ../../modules/tailscale/tailscale.nix
    (import ../../modules/k3s/k3s.nix { inherit config pkgs lib role; })
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
