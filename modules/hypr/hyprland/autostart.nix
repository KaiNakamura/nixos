{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # System services
      "systemctl --user start hyprpolkitagent"
      
      # Keyring services for password storage
      "/run/wrappers/bin/gnome-keyring-daemon --start --daemonize --components=gpg,pkcs11,secrets,ssh"
      
      # Clipboard management
      "wl-clip-persist --clipboard regular"
      "clipse -listen"
      
      # Color temperature
      "hyprsunset"
      
      # Notifications
      "mako"
      
      # Network manager applet
      "nm-applet --indicator"
    ];

    exec = [
      # Restart waybar if it crashes
      "pkill -SIGUSR2 waybar || waybar"
    ];
  };
}
