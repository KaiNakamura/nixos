{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--icons"
    ];
  };

  programs.zsh.shellAliases = {
    ls = "eza";
    la = "eza -a";
    ll = "eza -al";
    lt = "eza -a --tree --level=1";
  };
}
