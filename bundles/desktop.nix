{ config, pkgs, ... }:

{
  imports = [
    # Wayland desktop environment
    ../modules/hypr/hypr.nix
    ../modules/waybar/waybar.nix
    ../modules/mako/mako.nix
    ../modules/wofi/wofi.nix
    
    # Terminal emulator
    ../modules/kitty/kitty.nix
    
    # Power management
    ../modules/power/power.nix
  ];
}