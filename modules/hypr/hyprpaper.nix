{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${./wallpapers/astronaut-jellyfish-monokai.jpg}"
      ];
      wallpaper = [
        ",${./wallpapers/astronaut-jellyfish-monokai.jpg}"
      ];
      splash = false;
      ipc = "on";
    };
  };
}
