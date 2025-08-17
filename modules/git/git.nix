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
}
