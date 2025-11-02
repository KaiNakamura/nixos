{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Input configuration
    input = {
      kb_layout = "us";

      follow_mouse = 1;
      sensitivity = 0;  # base pointer scaling
      
      touchpad = {
        natural_scroll = true;
      };
    };

    # Cursor behavior
    cursor = {
      hide_on_key_press = true;
      inactive_timeout = 3;
    };

    # Device-specific configuration
    device = {
      name = "logitech-m705";
      sensitivity = -0.2;
    };
  };
}
