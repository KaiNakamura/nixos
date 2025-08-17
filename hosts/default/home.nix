{ config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # User packages
  home.packages = with pkgs; [
    gh
    nautilus # File manager
    networkmanagerapplet # Network manager GUI
    gnome-power-manager # Power management
  ];

  home.sessionVariables = {
    NIXOS_FLAKE = "/etc/nixos#default";
  };

  imports = [
    ../../modules/colors/colors.nix
    ../../modules/vim/vim.nix
    ../../modules/nvim/nvim.nix
    ../../modules/zsh/zsh.nix
    ../../modules/hypr/hypr.nix
    ../../modules/kitty/kitty.nix
    ../../modules/starship/starship.nix
    ../../modules/vscode/vscode.nix
    ../../modules/zoxide/zoxide.nix
    ../../modules/waybar/waybar.nix
    ../../modules/mako/mako.nix
    ../../modules/fonts/fonts.nix
    ../../modules/gowall/gowall.nix
    ../../modules/fastfetch/fastfetch.nix
    ../../modules/btop/btop.nix
    ../../modules/eza/eza.nix
    ../../modules/git/git.nix
    ../../modules/obsidian/obsidian.nix
    ../../modules/lazydocker/lazydocker.nix
    ../../modules/wofi/wofi.nix
    ../../modules/mpv/mpv.nix
    ../../modules/imv/imv.nix
    ../../modules/power/power.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
