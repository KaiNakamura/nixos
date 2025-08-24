{ config, pkgs, ... }:

let
  # Single source of truth for the SOPS age key file path
  ageKeyPath = "/var/lib/sops-nix/key.txt";
in
{
  # Install age and sops for secret management
  environment.systemPackages = with pkgs; [
    age  # For key generation and secret encryption/decryption
    sops  # For managing encrypted secrets in Git
  ];

  # Convenience aliases for age key management
  environment.shellAliases = {
    # Show the system-wide age public key (for adding to .sops.yaml)
    "age-key-show" = "sudo age-keygen -y ${ageKeyPath}";
  };

  # Set environment variables for interactive SOPS usage
  environment.variables = {
    SOPS_AGE_KEY_FILE = ageKeyPath;
  };

  # SOPS configuration
  sops = {
    # Default SOPS file location (relative to repo root)
    defaultSopsFile = ../../secrets.yaml;
    
    # Validate SOPS files at build time
    validateSopsFiles = false;
    
    # Age key configuration
    age = {
      # Use system-wide age key if it exists, otherwise user key
      keyFile = ageKeyPath;
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
