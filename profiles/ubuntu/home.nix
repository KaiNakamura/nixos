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
    ../../modules/fd/fd.nix
    ../../modules/bat/bat.nix
    ../../modules/fzf/fzf.nix
    ../../modules/ripgrep/ripgrep.nix
    ../../modules/tldr/tldr.nix
    ../../modules/delta/delta.nix

    # Terminal
    ../../modules/kitty/kitty.nix

    # Applications
    ../../modules/vscode/vscode.nix

    # TODO: Add GNOME module when created
    # ../../modules/gnome/gnome.nix
  ];

  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gh
    jq
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

