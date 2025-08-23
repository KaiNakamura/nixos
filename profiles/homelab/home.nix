# Homelab profile home configuration - minimal server setup
{ config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # Minimal packages for server management
  home.packages = with pkgs; [
    gh
  ];

  imports = [
    ../../modules/colors/colors.nix
    ../../modules/vim/vim.nix
    ../../modules/nvim/nvim.nix
    ../../modules/zsh/zsh.nix
    ../../modules/starship/starship.nix
    ../../modules/zoxide/zoxide.nix
    ../../modules/fastfetch/fastfetch.nix
    ../../modules/btop/btop.nix
    ../../modules/eza/eza.nix
    ../../modules/git/git.nix
    ../../modules/lazydocker/lazydocker.nix
    # Note: No GUI modules (hypr, kitty, waybar, etc.) for server
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
