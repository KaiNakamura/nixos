{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh.shellAliases = {
    ls = "eza -a --icons=always";
    ll = "eza -al --icons=always";
    lt = "eza -a --tree --level=1 --icons=always";
  };
}
