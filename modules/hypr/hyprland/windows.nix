{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Window rules
    windowrule = [
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
      "suppressevent maximize, class:.*"
      
      # Additional rules from omarchy
      "tile, class:^(chromium)$"  # Force chromium into tiles
      
      # Float certain applications
      "float, class:^(org.pulseaudio.pavucontrol|blueberry.py)$"
      "float, class:^(steam)$"
      
      # Fullscreen for games
      "fullscreen, class:^(com.libretro.RetroArch)$"
      
      # Opacity rules for better visual hierarchy
      "opacity 0.97 0.9, class:.*"  # Slight transparency for most apps
      "opacity 1 1, class:^(chromium|google-chrome|firefox)$, title:.*Youtube.*"  # No transparency for video
      "opacity 1 0.97, class:^(chromium|google-chrome|firefox)$"  # Minimal transparency for browsers
      "opacity 1 1, class:^(zoom|vlc|mpv|obs)$"  # No transparency for media apps
      "opacity 1 1, class:^(com.libretro.RetroArch|steam)$"  # No transparency for games
      
      # Fix XWayland focus issues
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      
      # Clipboard manager (clipse)
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "stayfocused, class:(clipse)"
    ];

    # Layer rules for blur effects
    layerrule = [
      "blur,wofi"
      "blur,waybar"
    ];
  };
}
