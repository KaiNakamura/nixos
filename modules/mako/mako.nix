{ pkgs, ... }:

{
  services.mako = {
    enable = true;
    
    settings = {
      # Notification appearance matching your Monokai theme
      background-color = "#272822";
      text-color = "#f8f8f2";
      border-color = "#75715e";
      progress-color = "over #a6e22e";
      
      # Layout settings
      width = 300;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 2;
      border-radius = 4;
      
      # Behavior
      default-timeout = 5000;
      ignore-timeout = 1;
      
      # Font
      font = "NotoSansM Nerd Font Mono 11";
      
      # Position (top-right corner)
      anchor = "top-right";
      
      # Group similar notifications
      group-by = "app-name";
      
      # Icons
      icon-path = "/run/current-system/sw/share/icons/Adwaita";
      max-icon-size = 48;
      
      # Urgency-specific settings
      "[urgency=low]" = {
        border-color = "#75715e";
      };
      
      "[urgency=normal]" = {
        border-color = "#66d9ef";
      };
      
      "[urgency=critical]" = {
        border-color = "#f92672";
        background-color = "#f92672";
        text-color = "#272822";
      };
    };
  };
}
