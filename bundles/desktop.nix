{ config, pkgs, inputs, ... }:

{
  # Display server and desktop environment
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Hyprland window manager
  programs.hyprland.enable = true;

  # Audio system
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing support
  services.printing.enable = true;

  # Keyring services for password storage
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Desktop applications
  programs.firefox.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.noto
  ];

  # Desktop-specific system packages
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    gnome-keyring
    libsecret
    gnome-power-manager
  ];

  imports = [
    ../modules/hypr/hypr.nix
    ../modules/kitty/kitty.nix
    ../modules/nvim/nvim.nix
    ../modules/waybar/waybar.nix
    ../modules/mako/mako.nix
    ../modules/fonts/fonts.nix
    ../modules/wofi/wofi.nix
    ../modules/power/power.nix
    ../modules/docker/docker.nix
    ../modules/lazydocker/lazydocker.nix
    ../modules/vscode/vscode.nix
    ../modules/obsidian/obsidian.nix
    ../modules/gowall/gowall.nix
    ../modules/mpv/mpv.nix
    ../modules/imv/imv.nix
  ];
}
