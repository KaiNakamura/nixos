{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      # For now, we'll use a simple solid color
      # You can add wallpapers later by modifying this configuration
      preload = [
        # Add wallpaper paths here when you want to use them
        # "/path/to/your/wallpaper.jpg"
      ];
      wallpaper = [
        # For now, using default (solid color from Hyprland)
        # ",/path/to/your/wallpaper.jpg"
      ];
      splash = false;
      ipc = "on";
    };
  };
  
  # Create a wallpapers directory for future use
  home.file."Pictures/Wallpapers/.keep".text = "";
}
