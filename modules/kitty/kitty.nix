{ ... }:

{
  programs.kitty = {
    enable = true;
  };

  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
}
