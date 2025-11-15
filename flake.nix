{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Helper function to create NixOS system configurations
      mkHost = { hostname, profile, extraModules ? [], extraArgs ? {} }: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; } // extraArgs;
        modules = [
          ./profiles/${profile}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          inputs.sops-nix.nixosModules.sops
          {
            networking.hostName = hostname;
          }
        ] ++ extraModules;
      };
      
      # Helper function to create standalone Home Manager configurations
      mkHomeConfig = { profile, system ? "x86_64-linux" }: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./profiles/${profile}/home.nix
        ];
      };
    in
    {
      nixosConfigurations = {
        t490 = mkHost { 
          hostname = "t490"; 
          profile = "desktop"; 
        };
        
        homelab-00 = mkHost { 
          hostname = "homelab-00"; 
          profile = "homelab"; 
          extraModules = [{ homelab.k3s.role = "server"; }];
        };
        
        homelab-01 = mkHost {
          hostname = "homelab-01"; 
          profile = "homelab"; 
          extraModules = [{ homelab.k3s.role = "agent"; }];
        };
      };
      
      homeConfigurations = {
        ubuntu = mkHomeConfig { 
          profile = "ubuntu"; 
        };
      };
    };
}
