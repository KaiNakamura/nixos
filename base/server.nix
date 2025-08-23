{ config, pkgs, inputs, ... }:

{
  imports = [
    # System-level modules only
    ../modules/docker/docker.nix
  ];

  # Enable SSH daemon for remote management
  services.openssh.enable = true;
  
  # Configure SSH settings
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = true; # You may want to disable this later
  };

  # Server-specific packages
  environment.systemPackages = with pkgs; [
    htop
    tmux
    curl
  ];

  # Open SSH port in firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
}
