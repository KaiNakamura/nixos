{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # General appearance
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      
      # Using your existing Monokai-inspired colors
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    # Window decorations
    decoration = {
      rounding = 4;  # Slightly less rounded than your current 10
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      
      shadow = {
        enabled = false;  # Keeping shadows disabled like your current config
        range = 30;
        render_power = 3;
        ignore_window = true;
        color = "rgba(00000045)";
      };

      blur = {
        enabled = true;
        size = 5;  # More blur than your current 3
        passes = 2;  # More passes than your current 1
        vibrancy = 0.1696;
      };
    };

    # Enhanced animations from omarchy
    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 0, 0, ease"  # Disable workspace animations to match your preference
      ];
    };

    # Workspace rules - Smart gaps (from your current config)
    workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    # Layouts
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
    };

    master = {
      new_status = "master";
    };

    # Miscellaneous
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;  # Additional from omarchy
    };
  };
}
