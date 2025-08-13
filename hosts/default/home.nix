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
  ];

  imports = [
    ../../modules/vim/vim.nix
    ../../modules/zsh/zsh.nix
    ../../modules/hypr/hypr.nix
    ../../modules/kitty/kitty.nix
    ../../modules/starship/starship.nix
    ../../modules/vscode/vscode.nix
    ../../modules/zoxide/zoxide.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
