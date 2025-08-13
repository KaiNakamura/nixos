{ self, config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  imports = [
    (self + /modules/vim/vim.nix)
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
