# NixOS

My NixOS configuration with modular Hyprland setup inspired by omarchy-nix.

## Features

### 🖥️ **Desktop Environment**

- **Hyprland** window manager with modular configuration
- **Waybar** status bar with system monitoring
- **Mako** notification daemon
- **Lock screen** with Hyprlock
- **Idle management** with Hypridle
- **Wallpaper management** with Hyprpaper

### 🛠️ **Applications & Tools**

- **Terminal**: Kitty with Monokai theme
- **Shell**: Zsh with starship prompt and smart features
- **Editor**: VS Code and Vim
- **File Manager**: Dolphin
- **Launcher**: Wofi
- **Clipboard**: Advanced clipboard management with clipse

### 🎨 **Theming**

- Consistent Monokai-inspired color scheme
- Custom transparency and blur effects
- Professional animations and transitions

### ⌨️ **Keybindings**

All keybindings preserved from original configuration:

- Vim-style movement (hjkl)
- Workspace management (1-0)
- Window manipulation
- Media controls

## New Modules Added

- `modules/waybar/` - Status bar configuration
- `modules/mako/` - Notification system
- `modules/hypr/hyprland/` - Modular Hyprland config
- `modules/hypr/hypridle.nix` - Idle management
- `modules/hypr/hyprlock.nix` - Lock screen
- `modules/hypr/hyprpaper.nix` - Wallpaper management

## Installation

Clone this repo, then create a symlink inside `/etc/nixos`

```sh
sudo rm -rf /etc/nixos
sudo ln -s ~/repos/nixos /etc/nixos
```

## Building

To rebuild and activate with flakes

```sh
sudo nixos-rebuild switch --flake /etc/nixos#default
```

**Note**: Flake builds only see committed files. Uncommitted changes are ignored unless you use `--impure`.

```sh
sudo nixos-rebuild switch --flake /etc/nixos#default --impure
```
