{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # Wayland-friendly fork
    terminal = "kitty";
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      display-ssh = "SSH";
      font = "Noto Sans Mono 12";
    };
    theme = let
      p = config.colorScheme.palette;
    in builtins.toFile "rofi-kai-monokai.rasi" ''
      * {
        font: "Noto Sans Mono 12";
        foreground: #${p.white};
        background: #${p.gray3}F2; /* slightly transparent */
        background-alt: #${p.gray2}F2;
        selected: #${p.gray1}F2;
        accent: #${p.green};
        urgent: #${p.red};
        active: #${p.green};
        border-color: #${p.gray1};
        spacing: 4px;
      }

      window {
        transparency: "real";
        padding: 15px;
        border: 2px;
        border-color: @border-color;
        background: @background;
      }

      mainbox { spacing: 10px; }
      inputbar {
        children: [ prompt, entry ];
        padding: 6px 8px;
        background: @background-alt;
        border: 1px solid @border-color;
      }
      prompt { padding: 0 6px 0 4px; background: #${p.gray1}CC; }
      entry { placeholder: "Type to search..."; }

      listview { lines: 12; columns: 1; dynamic: true; scrollbar: false; }
      element { padding: 4px 6px; }
      element selected { background: @selected; foreground: @foreground; }
      element urgent { background: @urgent; foreground: #${p.gray3}; }
      element active { background: @active; foreground: #${p.gray3}; }

      message { background: @background-alt; border: 1px solid @border-color; }
      scrollbar { handle-width: 4px; }
    '';
  };
}
