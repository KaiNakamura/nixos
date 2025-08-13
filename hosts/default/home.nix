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
    ../../modules/vscode/vscode.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
