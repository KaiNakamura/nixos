{ config, pkgs, ... }:

{
  imports = [
    ../../bundles/essentials.nix
    ../../bundles/desktop.nix
    ../../bundles/applications.nix
  ];

  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # Desktop user packages
  home.packages = with pkgs; [
    gh
    nautilus # File manager
    networkmanagerapplet # Network manager GUI
    gnome-power-manager # Power management
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
