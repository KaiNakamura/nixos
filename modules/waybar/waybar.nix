{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "bluetooth"
          "wireplumber"
          "cpu"
          "power-profiles-daemon"
          "battery"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };
        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = "kitty -e btop";
          tooltip-format = "CPU Usage: {usage}%";
        };
        clock = {
          format = "{:%A, %B %d, %Y, %I:%M %p}";
          tooltip = false;
        };
        battery = {
          interval = 5;
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged ";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          on-click = "gnome-power-manager";
          states = {
            warning = 20;
            critical = 10;
          };
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        wireplumber = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip-format = "Playing at {volume}%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 150;
        };
        tray = {
          spacing = 13;
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = "󰡳";
            balanced = "󰊚";
            performance = "󰡴";
          };
        };
      }
    ];
  };

  # Custom CSS styling
  # TODO: Maybe change to Noto
  home.file.".config/waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      min-height: 0;
      font-family: "Noto Sans Mono Nerd Font";
      font-size: 14px;
      color: #${config.colorScheme.palette.white};
    }

    window#waybar {
      background-color: #${config.colorScheme.palette.gray3};
      border-bottom: 2px solid #${config.colorScheme.palette.gray1};
    }

    #workspaces {
      margin-left: 7px;
    }

    #workspaces button {
      all: initial;
      padding: 2px 6px;
      margin-right: 3px;
      color: #${config.colorScheme.palette.gray1};
    }

    #workspaces button.active {
      color: #${config.colorScheme.palette.white};
      background-color: #${config.colorScheme.palette.gray1};
    }

    #workspaces button:hover {
      color: #${config.colorScheme.palette.white};
      background-color: #${config.colorScheme.palette.gray2};
    }

    #cpu,
    #power-profiles-daemon,
    #battery,
    #bluetooth,
    #wireplumber,
    #tray,
    #clock {
      background-color: transparent;
      min-width: 12px;
      margin-right: 13px;
    }

    #clock {
      font-weight: bold;
    }

    #battery.warning {
      color: #${config.colorScheme.palette.orange};
    }

    #battery.critical {
      color: #${config.colorScheme.palette.red};
    }

    tooltip {
      padding: 2px;
      background-color: #${config.colorScheme.palette.gray3};
      border: 1px solid #${config.colorScheme.palette.gray1};
    }

    tooltip label {
      padding: 2px;
      color: #${config.colorScheme.palette.white};
    }
  '';

  # GTK theme configuration for nm-applet to match system colors
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    font = {
      name = "Noto Sans";
      size = 11;
    };
  };

  # Custom GTK CSS for nm-applet to use your color scheme
  home.file.".config/gtk-3.0/gtk.css".text = ''
    /* NetworkManager applet theming */
    .nm-applet-menu {
      background-color: #${config.colorScheme.palette.gray3};
      color: #${config.colorScheme.palette.white};
      border: 1px solid #${config.colorScheme.palette.gray1};
    }

    .nm-applet-menu menuitem {
      background-color: transparent;
      color: #${config.colorScheme.palette.white};
    }

    .nm-applet-menu menuitem:hover {
      background-color: #${config.colorScheme.palette.gray2};
    }

    .nm-applet-menu menuitem:selected {
      background-color: #${config.colorScheme.palette.gray1};
    }

    /* General popover/menu styling */
    popover, menu {
      background-color: #${config.colorScheme.palette.gray3};
      color: #${config.colorScheme.palette.white};
      border: 1px solid #${config.colorScheme.palette.gray1};
    }

    popover menuitem, menu menuitem {
      color: #${config.colorScheme.palette.white};
    }

    popover menuitem:hover, menu menuitem:hover {
      background-color: #${config.colorScheme.palette.gray2};
    }
  '';

  home.packages = with pkgs; [
    waybar
    networkmanagerapplet  # Network manager applet (nm-applet)
    blueberry  # Bluetooth manager
    pavucontrol  # Audio control
    power-profiles-daemon  # Power management
  ];
}
