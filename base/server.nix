{ config, pkgs, inputs, ... }:

{
  imports = [
    ../modules/secrets/secrets.nix
  ];

  environment.systemPackages = with pkgs; [
    kubectl
    helm
  ];
}
