{ config, pkgs, ... }:

{
  # Install age and sops for secret management
  environment.systemPackages = with pkgs; [
    age  # For key generation and secret encryption/decryption
    sops  # For managing encrypted secrets in Git
  ];

  # Convenience aliases for age key management
  environment.shellAliases = {
    # Generate a new age key for SOPS
    "age-key-setup" = "mkdir -p ~/.config/sops/age && age-keygen -o ~/.config/sops/age/keys.txt && echo 'Age key generated at ~/.config/sops/age/keys.txt'";
    
    # Show the public key for adding to .sops.yaml
    "age-key-show" = "age-keygen -y ~/.config/sops/age/keys.txt";
  };

  # SOPS configuration
  sops = {
    # Default SOPS file location
    defaultSopsFile = ../../../secrets.yaml;
    
    # Validate SOPS files at build time
    validateSopsFiles = false;
    
    # Age key configuration
    age = {
      # Use system-wide age key if it exists, otherwise user key
      keyFile = "/var/lib/sops-nix/key.txt";
      # Generate a host key automatically if none exists
      generateKey = true;
    };
  };

  # Create the SOPS age directory structure
  # This ensures the directory exists for key storage
  system.activationScripts.sopsAgeDir = ''
    mkdir -p /etc/sops/age
    mkdir -p /var/lib/sops-nix
  '';
}
