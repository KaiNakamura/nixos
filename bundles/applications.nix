{ config, pkgs, ... }:

{
  imports = [
    # Applications
    ../modules/obsidian/obsidian.nix
    ../modules/vscode/vscode.nix
    
    # Media applications
    ../modules/mpv/mpv.nix
    ../modules/imv/imv.nix
    
    # System utilities
    ../modules/gowall/gowall.nix
  ];
}
