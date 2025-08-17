{ config, pkgs, ... }:

let
  # Convert the provided SVG logo into a PNG in the Nix store for fastfetch image logo usage
  nixosLogoPng = pkgs.runCommand "nixos-logo-fastfetch.png" { buildInputs = [ pkgs.librsvg ]; } ''
    rsvg-convert -w 256 -h 256 ${./logos/nixos.svg} -o $out
  '';
in
{
  programs.fastfetch = {
    enable = true;
  };

  home.file.".config/fastfetch/config.jsonc".text = ''
  {
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
      "type": "kitty",
      "source": "${nixosLogoPng}",
      "height": 15
    },
    "display": {
      "separator": " "
    },
    "modules": [
      { "key": "╭───────────╮", "type": "custom" },
      { "key": "│  user    │", "type": "title", "format": "{user-name}" },
      { "key": "│ 󰇅 hname   │", "type": "title", "format": "{host-name}" },
      { "key": "│ 󰅐 uptime  │", "type": "uptime" },
      { "key": "│ {icon} distro  │", "type": "os" },
      { "key": "│  kernel  │", "type": "kernel" },
      { "key": "│  wm      │", "type": "wm" },
      { "key": "│ 󰇄 desktop │", "type": "de" },
      { "key": "│  term    │", "type": "terminal" },
      { "key": "│  shell   │", "type": "shell" },
      { "key": "│ 󰍛 cpu     │", "type": "cpu" },
      { "key": "│ 󰉉 disk    │", "type": "disk", "folders": "/" },
      { "key": "│  memory  │", "type": "memory" },
      { "key": "├───────────┤", "type": "custom" },
      { "key": "│  colors  │", "type": "colors", "symbol": "circle" },
      { "key": "╰───────────╯", "type": "custom" }
    ]
  }
  '';
}