{ config, pkgs, lib, ... }:

{
  options.services.tailscale.enableSSH = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''Enable Tailscale SSH (--ssh flag) via autoconnect script.'';
  };

  config = {
    # Enable Tailscale service
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    # Configure SOPS secret for Tailscale auth key
    sops.secrets."tailscale/homelab" = {
      sopsFile = ../../secrets.yaml;
    };

    # Open required firewall ports for Tailscale
    networking.firewall = {
      # Allow Tailscale to configure firewall rules
      trustedInterfaces = [ "tailscale0" ];
      
      # Allow Tailscale UDP port 41641 (default DERP port)
      # Source: https://tailscale.com/kb/1082/firewall-ports/
      allowedUDPPorts = [ 41641 ];
    };

    # Automatic Tailscale authentication using systemd service
    # Source: https://github.com/Mic92/sops-nix/blob/master/docs/faq.md
    systemd.services.tailscale-autoconnect = let
      sshFlag = lib.optionalString config.services.tailscale.enableSSH " --ssh";
    in {
      description = "Automatic connection to Tailscale";
      after = [ "network-pre.target" "tailscale.service" "sops-nix.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        # Wait for tailscale to be ready
        sleep 2
        
        # Check if already authenticated using tailscale status
        if ! ${pkgs.tailscale}/bin/tailscale status >/dev/null 2>&1; then
          echo "Authenticating Tailscale with SOPS-managed auth key..."
          FLAGS="--auth-key=file:${config.sops.secrets."tailscale/homelab".path} --accept-routes --accept-dns=false${sshFlag}"
          ${pkgs.tailscale}/bin/tailscale up $FLAGS
        fi
      '';
    };
  };
}
