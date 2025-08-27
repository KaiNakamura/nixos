{ config, pkgs, ... }:

{
  imports = [
    # Essentials
    ../../modules/colors/colors.nix
    ../../modules/fonts/fonts.nix
    ../../modules/zsh/zsh.nix
    ../../modules/starship/starship.nix
    ../../modules/zoxide/zoxide.nix
    ../../modules/eza/eza.nix
    ../../modules/git/git.nix
    ../../modules/vim/vim.nix
    ../../modules/nvim/nvim.nix
    ../../modules/btop/btop.nix
    ../../modules/fastfetch/fastfetch.nix
    ../../modules/lazydocker/lazydocker.nix
    ../../modules/k9s/k9s.nix
  ];

  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
