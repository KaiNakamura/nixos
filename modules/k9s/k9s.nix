{ pkgs, ... }:
{
  home.packages = [ pkgs.k9s ];

  programs.zsh.shellAliases = {
    k9 = "k9s";
  };
}