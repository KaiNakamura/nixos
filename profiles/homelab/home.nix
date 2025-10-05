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
    ../../modules/lazydocker/lazydocker.nix
    ../../modules/k9s/k9s.nix

    # TODO: Likely remove below
    # Desktop
    ../../modules/hypr/hypr.nix
    ../../modules/waybar/waybar.nix
    ../../modules/mako/mako.nix
    ../../modules/wofi/wofi.nix
    ../../modules/kitty/kitty.nix
    ../../modules/power/power.nix

    # Applications
    ../../modules/obsidian/obsidian.nix
    ../../modules/vscode/vscode.nix
    ../../modules/cursor-ai/cursor-ai.nix
    ../../modules/mpv/mpv.nix
    ../../modules/imv/imv.nix
    ../../modules/gowall/gowall.nix
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
