{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    
    # Notification appearance matching your Monokai theme
    backgroundColor = "#272822";
    textColor = "#f8f8f2";
    borderColor = "#75715e";
    progressColor = "over #a6e22e";
    
    # Layout settings
    width = 300;
    height = 110;
    padding = "10";
    margin = "10";
    borderSize = 2;
    borderRadius = 4;
    
    # Behavior
    defaultTimeout = 5000;
    ignoreTimeout = true;
    
    # Font
    font = "NotoSansM Nerd Font Mono 11";
    
    # Position (top-right corner)
    anchor = "top-right";
    
    # Group similar notifications
    groupBy = "app-name";
    
    # Icons
    iconPath = "/run/current-system/sw/share/icons/Adwaita";
    maxIconSize = 48;
    
    # Extra config for better appearance
    extraConfig = ''
      [urgency=low]
      border-color=#75715e
      
      [urgency=normal]
      border-color=#66d9ef
      
      [urgency=critical]
      border-color=#f92672
      background-color=#f92672
      text-color=#272822
    '';
  };
}
