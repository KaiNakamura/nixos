{ pkgs, config, ... }:

{
  # Install required packages
  home.packages = with pkgs; [
    wlogout
    jq
  ];

  # Create power management script
  home.file.".config/hypr/scripts/power.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Minimal power management script for NixOS

      terminate_clients() {
        TIMEOUT=5
        client_pids=$(hyprctl clients -j | ${pkgs.jq}/bin/jq -r '.[] | .pid' 2>/dev/null)
        
        for pid in $client_pids; do
          kill -15 "$pid" 2>/dev/null || true
        done

        start_time=$(date +%s)
        for pid in $client_pids; do
          while kill -0 "$pid" 2>/dev/null; do
            current_time=$(date +%s)
            elapsed_time=$((current_time - start_time))
            
            if [ $elapsed_time -ge $TIMEOUT ]; then
              return 0
            fi
            
            sleep 0.5
          done
        done
      }

      case "$1" in
        "exit"|"logout")
          terminate_clients
          sleep 0.5
          hyprctl dispatch exit
          ;;
        "lock")
          ${pkgs.hyprlock}/bin/hyprlock
          ;;
        "reboot")
          terminate_clients
          sleep 0.5
          systemctl reboot
          ;;
        "shutdown")
          terminate_clients
          sleep 0.5
          systemctl poweroff
          ;;
        "suspend")
          systemctl suspend
          ;;
        *)
          echo "Usage: $0 {exit|lock|reboot|shutdown|suspend}"
          exit 1
          ;;
      esac
    '';
    executable = true;
  };

  # Wlogout launcher script
  home.file.".config/hypr/scripts/wlogout.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Launch wlogout with rofi-style layout
      ${pkgs.wlogout}/bin/wlogout -b 5 -c 0 -r 0 -m 0 --layout ~/.config/wlogout/layout --css ~/.config/wlogout/style.css
    '';
    executable = true;
  };

  # wlogout layout with vim keybinds
  home.file.".config/wlogout/layout" = {
    text = ''
      {
          "label" : "lock",
          "action" : "~/.config/hypr/scripts/power.sh lock",
          "text" : "Lock",
          "keybind" : "l"
      }
      {
          "label" : "logout",
          "action" : "~/.config/hypr/scripts/power.sh exit",
          "text" : "Logout",
          "keybind" : "e"
      }
      {
          "label" : "suspend",
          "action" : "~/.config/hypr/scripts/power.sh suspend",
          "text" : "Suspend",
          "keybind" : "s"
      }
      {
          "label" : "reboot",
          "action" : "~/.config/hypr/scripts/power.sh reboot",
          "text" : "Reboot",
          "keybind" : "r"
      }
      {
          "label" : "shutdown",
          "action" : "~/.config/hypr/scripts/power.sh shutdown",
          "text" : "Shutdown",
          "keybind" : "p"
      }
    '';
  };

  # Minimal wlogout styling with your color scheme
  home.file.".config/wlogout/style.css" = {
    text = ''
      * {
          background-image: none;
          box-shadow: none;
          text-shadow: none;
          transition: none;
      }

      window {
          background-color: rgba(30, 31, 28, 0.9); /* black with transparency */
      }

      button {
          color: #${config.colorScheme.palette.white};
          background-color: #${config.colorScheme.palette.gray3};
          border: 2px solid #${config.colorScheme.palette.gray2};
          border-radius: 4px;
          margin: 4px 0px;
          font-family: "Noto Sans Mono Nerd Font";
          font-size: 16px;
          font-weight: normal;
          min-width: 200px;
          min-height: 40px;
          background-repeat: no-repeat;
          background-position: left 12px center;
          background-size: 20px;
          padding-left: 45px;
          text-align: left;
      }

      button:focus, button:active {
          background-color: #${config.colorScheme.palette.gray1};
          border-color: #${config.colorScheme.palette.white};
          color: #${config.colorScheme.palette.white};
          outline: none;
      }

      button:hover {
          background-color: #${config.colorScheme.palette.gray2};
          border-color: #${config.colorScheme.palette.gray0};
          color: #${config.colorScheme.palette.white};
      }

      /* Remove icons and use text only for minimal approach */
      #lock {
          background-image: none;
      }

      #logout {
          background-image: none;
      }

      #suspend {
          background-image: none;
      }

      #reboot {
          background-image: none;
      }

      #shutdown {
          background-image: none;
      }
    '';
  };
}
