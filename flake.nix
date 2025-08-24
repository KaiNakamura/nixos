{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      # Helper function to create host configurations
      mkHost = hostname: profile: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./profiles/${profile}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          {
            networking.hostName = hostname;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        t490 = mkHost "t490" "desktop";
        homelab-00 = mkHost "homelab-00" "desktop";
        homelab-01 = mkHost "homelab-01" "desktop";
      };
    };
}
