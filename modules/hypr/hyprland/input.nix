{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Input configuration
    input = {
      kb_layout = "us";
      kb_options = "compose:caps";  # Use Caps Lock as compose key

      follow_mouse = 1;
      sensitivity = 0;  # No mouse acceleration
      
      touchpad = {
        natural_scroll = true;  # Keep your preference for natural scroll
      };
    };

    # Cursor behavior
    cursor = {
      hide_on_key_press = true;
      inactive_timeout = 3;
    };

    # Gestures
    gestures = {
      workspace_swipe = false;
    };

    # Device-specific configurations can be added here
    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };
  };
}
