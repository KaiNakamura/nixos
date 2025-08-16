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
          "network"
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
          format = "{:%A %I:%M %p}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };
        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "nm-connection-editor";
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
          format = "";
          format-muted = "󰝟";
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
      font-family: "CaskaydiaMono Nerd Font Mono";
      font-size: 14px;
      color: ${config.colorScheme.palette.white};
    }

    window#waybar {
      background-color: ${config.colorScheme.palette.gray2}
      border-bottom: 2px solid ${config.colorScheme.palette.gray1};
    }

    #workspaces {
      margin-left: 7px;
    }

    #workspaces button {
      all: initial;
      padding: 2px 6px;
      margin-right: 3px;
      color: ${config.colorScheme.palette.gray1};
    }

    #workspaces button.active {
      color: ${config.colorScheme.palette.white};
      background-color: ${config.colorScheme.palette.gray1};
    }

    #workspaces button:hover {
      color: ${config.colorScheme.palette.white};
      background-color: ${config.colorScheme.palette.gray2};
    }

    #cpu,
    #power-profiles-daemon,
    #battery,
    #network,
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
      color: ${config.colorScheme.palette.orange};
    }

    #battery.critical {
      color: ${config.colorScheme.palette.red};
    }

    tooltip {
      padding: 2px;
      background-color: ${config.colorScheme.palette.gray3};
      border: 1px solid ${config.colorScheme.palette.gray1};
    }

    tooltip label {
      padding: 2px;
      color: ${config.colorScheme.palette.white};
    }
  '';

  home.packages = with pkgs; [
    waybar
    blueberry  # Bluetooth manager
    pavucontrol  # Audio control
    power-profiles-daemon  # Power management
  ];
}
