{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  theme = ''
* {
  bg: #${palette.gray3};
  bg-alt: #${palette.gray2};
  fg: #${palette.white};
  fg-alt: #${palette.gray0};
  accent: #${palette.orange};
  accent-alt: #${palette.yellow};
  border: #${palette.gray1};
  urgent: #${palette.red};
  selected: #${palette.gray1};
}

window {
  background-color: @bg;
  border: 2px;
  border-color: @border;
  padding: 8px;
}

mainbox { padding: 0px; }
inputbar {
  children: [ prompt, entry ];
  background-color: @bg-alt;
  padding: 6px 10px;
  border-radius: 6px;
}
prompt { text-color: @accent; }
entry { placeholder: "Search"; }
listview { columns: 1; lines: 12; scrollbar: false; }

element { padding: 4px 8px; }
element normal.normal { background-color: transparent; text-color: @fg; }
element selected.normal { background-color: @selected; text-color: @fg; }
element alternate.normal { background-color: transparent; }

message { background-color: @bg-alt; }
'';
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "Noto Sans Mono Nerd Font 11";
    terminal = "kitty";
    extraConfig = {
      modi = "drun,window,run";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "";
      display-run = "";
      display-window = "";
      hover-select = false;
      scroll-method = 1;
    };
    theme = lib.mkForce (builtins.toFile "rofi-theme-kai.rasi" theme);
  };
}
