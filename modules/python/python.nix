{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
  ];

  programs.zsh.shellAliases = {
    python = "python3";
    pip = "pip3";
  };
}
