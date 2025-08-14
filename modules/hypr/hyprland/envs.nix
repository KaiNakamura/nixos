{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Environment variables for better Wayland compatibility
    env = [
      # Cursor settings
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,Adwaita"
      "HYPRCURSOR_THEME,Adwaita"

      # Force applications to use Wayland
      "GDK_BACKEND,wayland"
      "QT_QPA_PLATFORM,wayland"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"

      # Make Chromium use Wayland properly
      "CHROMIUM_FLAGS,--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4"

      # Make .desktop files available for wofi
      "XDG_DATA_DIRS,$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share"

      # Editor preference
      "EDITOR,vim"
      
      # GTK theme
      "GTK_THEME,Adwaita:dark"
    ];

    # XWayland settings
    xwayland = {
      force_zero_scaling = true;
    };

    # Disable update notifications
    ecosystem = {
      no_update_news = true;
    };
  };
}
