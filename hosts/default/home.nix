{ self, config, pkgs, ... }:

{
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  imports = [
    (self + /modules/vim/vim.nix)
    (self + /modules/vscode/vscode.nix)
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
