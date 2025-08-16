{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system
  # You can disable this if you're only using the Wayland session
  services.xserver.enable = true;

  # Enable the display manager for Hyprland
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Define a user account
  # Don't forget to set a password with ‘passwd’
  users.users.kai = {
    isNormalUser = true;
    description = "Kai Nakamura";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # Install firefox
  programs.firefox.enable = true;
  
  # Enable zsh system-wide
  programs.zsh.enable = true;
  
  # Make zsh a valid login shell and the default for users
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.caskaydia-mono
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
    git
    networkmanagerapplet
    gnome-power-manager
    home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
