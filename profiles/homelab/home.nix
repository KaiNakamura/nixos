{ config, pkgs, ... }:

{
  imports = [
    ../../bundles/essentials.nix
  ];

  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # Minimal packages for server management
  home.packages = with pkgs; [
    gh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
