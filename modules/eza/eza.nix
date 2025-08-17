{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--icons"
      "--header"
      "--time-style=long-iso"
    ];
  };

  programs.zsh.shellAliases = {
    ls = "eza -a";
    ll = "eza -al";
    lt = "eza -a --tree --level=1";
  };
}
