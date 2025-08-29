{ pkgs, ... }:
{
  programs.tealdeer = {
    enable = true;
    settings = {
      # Update cache automatically
      auto_update = true;
    };
  };
}
