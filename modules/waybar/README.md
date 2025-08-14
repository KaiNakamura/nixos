# Waybar Module

A status bar for Hyprland with system monitoring capabilities.

## Features

- **Workspaces**: Interactive workspace indicators with Hyprland integration
- **System Info**: CPU usage, battery status, network connectivity
- **Audio Control**: Volume control with PipeWire/Wireplumber support
- **Power Management**: Power profile daemon integration
- **Bluetooth**: Bluetooth status and management
- **System Tray**: Application tray support
- **Clock**: Date and time display with alternate format

## Key Bindings

- Click on workspace numbers to switch workspaces
- Click on CPU icon to open btop in terminal
- Click on network icon to open nmcli in terminal
- Click on volume icon to open pavucontrol
- Right-click on volume icon to toggle mute
- Click on bluetooth icon to open blueberry (bluetooth manager)

## Customization

The module includes Monokai-themed styling that matches your Kitty terminal colors:

- Background: Semi-transparent dark theme
- Accent colors: Matching your existing color scheme
- Font: Uses your NotoSansM Nerd Font Mono

## Dependencies

The module automatically installs:

- waybar (the status bar)
- blueberry (bluetooth manager)
- pavucontrol (audio control panel)
- power-profiles-daemon (power management)

Your existing btop package works with the CPU monitoring feature.
