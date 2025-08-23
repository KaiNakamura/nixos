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
            networking.hostName = hostname;  # Override placeholder
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        # Desktop machine (ThinkPad T490)
        t490 = mkHost "t490" "desktop";
        
        # Homelab cluster (HP ProDesk machines)
        homelab-00 = mkHost "homelab-00" "homelab";
        homelab-01 = mkHost "homelab-01" "homelab";
        homelab-02 = mkHost "homelab-02" "homelab";
      };
    };
}
