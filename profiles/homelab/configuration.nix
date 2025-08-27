{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../../base/base.nix
    ../../modules/secrets/secrets.nix
    ../../modules/tailscale/tailscale.nix
    ../../modules/k3s/k3s.nix
    inputs.home-manager.nixosModules.default
  ];

  # Enable Tailscale SSH for homelab profile
  services.tailscale.enableSSH = true;

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };
}
