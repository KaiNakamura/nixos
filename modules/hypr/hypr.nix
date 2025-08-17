{ pkgs, ... }:

{
  imports = [
    ./hyprland/autostart.nix
    ./hyprland/envs.nix
    ./hyprland/input.nix
    ./hyprland/looknfeel.nix
    ./hyprland/windows.nix
    ./hyprland/keybinds.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Cursor configuration
      cursor = {
        no_hardware_cursors = true;
      };

      # Disable middle-click paste
      misc = {
        middle_click_paste = false;
      };
    };
  };

  # Cursor theme configuration
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # Install required packages
  home.packages = with pkgs; [
    # Core Hyprland tools
    hyprland
    
    # Media and system control
    brightnessctl
    playerctl
    
    # Clipboard management
    wl-clip-persist
    clipse
    
    # Color temperature
    hyprsunset
    
    # Additional utilities from omarchy
    hyprshot      # Screenshots
    hyprpicker    # Color picker
    pamixer       # Audio mixer
  ];
}
