{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Kai Nakamura";
    userEmail = "kaihnakamura@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.zsh.shellAliases = {
    gs = "git status";
    ga = "git add";
    gm = "git commit -m";
    gam = "git add && git commit -m";
    gb = "git branch";
    gp = "git push";
    gpo = "git push origin";
    gc = "git checkout";
    gl = "git log";
  };
}
