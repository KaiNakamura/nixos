{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Kai Nakamura";
      user.email = "kaihnakamura@gmail.com";
      init.defaultBranch = "main";
      core.excludesFile = "~/.gitignore_global";
      url."ssh://git@github.com".insteadOf = "https://github.com";
      pager.branch = false;
    };
  };

  home.file.".gitignore_global" = {
    text = ''
      *.swp
      *.code-workspace
      .vscode/
    '';
  };

  programs.zsh.shellAliases = {
    g = "git";
    gs = "git status";
    ga = "git add";
    gm = "git commit -m";
    gam = "git add . && git commit -m";
    gb = "git branch";
    gp = "git push";
    gpo = "git push origin";
    gpu = "git pull origin";
    gc = "git checkout";
    gl = "git log";
  };
}
