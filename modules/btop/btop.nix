{ pkgs, config, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      # Use truecolor and transparent background to blend with terminal theme
      truecolor = true;
      theme_background = false;
    };
  };
}
