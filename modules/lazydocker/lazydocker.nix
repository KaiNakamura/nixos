{ pkgs, ... }:
{
  home.packages = [ pkgs.lazydocker ];

  programs.zsh.shellAliases = {
    ld = "lazydocker";
  };
}
