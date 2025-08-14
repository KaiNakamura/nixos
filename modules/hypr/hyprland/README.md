# Hyprland Configuration Modules

This directory contains modular Hyprland configuration files imported from omarchy-nix.

## Modules

- `autostart.nix` - Applications that start automatically with Hyprland
- `envs.nix` - Environment variables and system settings
- `input.nix` - Input device configuration (keyboard, mouse, touchpad)
- `looknfeel.nix` - Visual appearance, animations, and window decorations
- `windows.nix` - Window rules and layer rules
- `keybinds.nix` - Your custom keybindings (preserved from original config)

## Features Added

- **Better environment variables** for Wayland compatibility
- **Enhanced window rules** with opacity management
- **Professional animations** and blur effects
- **Clipboard management** with clipse
- **Automatic service management** (polkit agent, etc.)
- **Layer blur** for wofi and waybar
- **XWayland compatibility** fixes

## Theming

Currently using fallback colors that match your Monokai theme. Can be enhanced later with nix-colors integration for dynamic theming.
