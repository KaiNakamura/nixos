{ config, pkgs, lib, ... }:

let
  # Path to scripts directory
  scriptsDir = ./scripts;
  
  # Helper scripts for window management
  # Note: For Wayland, these use gdbus. For X11, wmctrl would work better.
  # Consider installing GNOME extensions like "gTile" or "Put Windows" for better window management.
  
  windowMoveScripts = {
    # Focus movement scripts (using gdbus for Wayland)
    focusLeft = pkgs.writeShellScriptBin "gnome-focus-left" (builtins.readFile "${scriptsDir}/focus-left.sh");
    focusRight = pkgs.writeShellScriptBin "gnome-focus-right" (builtins.readFile "${scriptsDir}/focus-right.sh");
    focusUp = pkgs.writeShellScriptBin "gnome-focus-up" (builtins.readFile "${scriptsDir}/focus-up.sh");
    focusDown = pkgs.writeShellScriptBin "gnome-focus-down" (builtins.readFile "${scriptsDir}/focus-down.sh");
    
    # Window movement scripts
    moveLeft = pkgs.writeShellScriptBin "gnome-move-window-left" (builtins.readFile "${scriptsDir}/move-left.sh");
    moveRight = pkgs.writeShellScriptBin "gnome-move-window-right" (builtins.readFile "${scriptsDir}/move-right.sh");
    moveUp = pkgs.writeShellScriptBin "gnome-move-window-up" (builtins.readFile "${scriptsDir}/move-up.sh");
    moveDown = pkgs.writeShellScriptBin "gnome-move-window-down" (builtins.readFile "${scriptsDir}/move-down.sh");
  };
in
{
  # Install helper scripts
  home.packages = with pkgs; [
    windowMoveScripts.focusLeft
    windowMoveScripts.focusRight
    windowMoveScripts.focusUp
    windowMoveScripts.focusDown
    windowMoveScripts.moveLeft
    windowMoveScripts.moveRight
    windowMoveScripts.moveUp
    windowMoveScripts.moveDown
  ];

  # Configure GNOME keybinds via dconf/gsettings
  # This mirrors the Hyprland keybinds from modules/hypr/hyprland/keybinds.nix
  dconf.settings = {
    # Window management - match Hyprland
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];  # Match Hyprland: Super+q to close
      maximize = ["<Super>Up"];
      minimize = ["<Super>Down"];
      toggle-fullscreen = ["<Super>m"];  # Match Hyprland: Super+m for fullscreen
      
      # Workspace switching - Super+1-9,0 (match Hyprland)
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
      
      # Move window to workspace - Super+Shift+1-9,0 (match Hyprland)
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];
      
      # Workspace navigation - Super+Ctrl+h/l (match Hyprland)
      switch-to-workspace-left = ["<Super><Control>h"];
      switch-to-workspace-right = ["<Super><Control>l"];
      move-to-workspace-left = ["<Super><Control><Shift>h"];
      move-to-workspace-right = ["<Super><Control><Shift>l"];
    };

    # Workspace settings - use fixed workspaces (like Omakub but with 10 workspaces to match Hyprland)
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;  # Match Hyprland's 10 workspaces
    };

    # Custom keybindings for window movement and focus (hjkl style)
    # Reserve slots for custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11/"
      ];
    };

    # Focus movement - Super+h/j/k/l (match Hyprland)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Focus Left";
      command = "${windowMoveScripts.focusLeft}/bin/gnome-focus-left";
      binding = "<Super>h";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Focus Down";
      command = "${windowMoveScripts.focusDown}/bin/gnome-focus-down";
      binding = "<Super>j";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Focus Up";
      command = "${windowMoveScripts.focusUp}/bin/gnome-focus-up";
      binding = "<Super>k";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Focus Right";
      command = "${windowMoveScripts.focusRight}/bin/gnome-focus-right";
      binding = "<Super>l";
    };

    # Window movement - Super+Shift+h/j/k/l (match Hyprland)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      name = "Move Window Left";
      command = "${windowMoveScripts.moveLeft}/bin/gnome-move-window-left";
      binding = "<Super><Shift>h";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      name = "Move Window Down";
      command = "${windowMoveScripts.moveDown}/bin/gnome-move-window-down";
      binding = "<Super><Shift>j";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
      name = "Move Window Up";
      command = "${windowMoveScripts.moveUp}/bin/gnome-move-window-up";
      binding = "<Super><Shift>k";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
      name = "Move Window Right";
      command = "${windowMoveScripts.moveRight}/bin/gnome-move-window-right";
      binding = "<Super><Shift>l";
    };

    # Application launchers - match Hyprland
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" = {
      name = "Terminal";
      command = "kitty";
      binding = "<Super>n";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9" = {
      name = "File Manager";
      command = "nautilus";
      binding = "<Super>e";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10" = {
      name = "Browser";
      command = "firefox";
      binding = "<Super>f";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom11" = {
      name = "Application Menu";
      command = "wofi --show drun";
      binding = "<Super>r";
    };
  };

  # Disable conflicting default keybindings
  # Disable Dash to Dock hotkeys (like Omakub does)
  dconf.settings."org/gnome/shell/extensions/dash-to-dock" = {
    hot-keys = false;
  };
}

