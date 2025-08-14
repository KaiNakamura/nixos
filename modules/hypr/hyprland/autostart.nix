{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # System services
      "systemctl --user start hyprpolkitagent"
      
      # Clipboard management
      "wl-clip-persist --clipboard regular"
      "clipse -listen"
      
      # Color temperature
      "hyprsunset"
      
      # Notifications
      "mako"
      
      # Status bar (managed by waybar module)
      "waybar"
    ];

    exec = [
      # Restart waybar if it crashes
      "pkill -SIGUSR2 waybar || waybar"
    ];
  };
}
