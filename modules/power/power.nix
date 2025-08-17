{ pkgs, ... }:

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
      # Launch wlogout with minimal configuration
      ${pkgs.wlogout}/bin/wlogout -b 5
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

  # Minimal wlogout styling
  home.file.".config/wlogout/style.css" = {
    text = ''
      * {
          background-image: none;
          box-shadow: none;
      }

      window {
          background-color: rgba(0, 0, 0, 0.8);
      }

      button {
          color: #ffffff;
          background-color: rgba(40, 40, 40, 0.9);
          border: 2px solid #555555;
          border-radius: 8px;
          margin: 5px;
          font-size: 18px;
          min-width: 120px;
          min-height: 60px;
      }

      button:focus, button:active {
          background-color: rgba(80, 80, 80, 0.9);
          border-color: #ffffff;
          outline: none;
      }

      button:hover {
          background-color: rgba(60, 60, 60, 0.9);
          border-color: #cccccc;
      }
    '';
  };
}
