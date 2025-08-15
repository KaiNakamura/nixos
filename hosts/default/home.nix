{ config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # User packages
  home.packages = with pkgs; [
    gh
    zsh
    oh-my-zsh
    kitty
    starship
    zoxide
    nautilus          # File manager
    networkmanagerapplet  # Network manager GUI
    gnome-power-manager   # Power management
    blueberry            # Bluetooth manager
    bibata-cursors       # Cursor theme
  ];

  imports = [
    ../../modules/vim/vim.nix
    ../../modules/zsh/zsh.nix
    ../../modules/hypr/hypr.nix
    ../../modules/kitty/kitty.nix
    ../../modules/starship/starship.nix
    ../../modules/vscode/vscode.nix
    ../../modules/zoxide/zoxide.nix
    ../../modules/waybar/waybar.nix
    ../../modules/mako/mako.nix
    ../../modules/fonts/fonts.nix
  ];

  # Firefox: disable middle-click paste & primary selection autocopy
  programs.firefox = {
    enable = true; # profile-level settings
    profiles.default = {
      id = 0;
      settings = {
        "middlemouse.paste" = false;
        "clipboard.autocopy" = false;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
