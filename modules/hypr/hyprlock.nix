{ pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        no_fade_in = false;
      };
      
      auth = {
        fingerprint.enabled = true;
      };
      
      background = {
        monitor = "";
        # Using a simple color background for now - can be replaced with wallpaper later
        color = "rgba(39, 40, 34, 1.0)";  # Monokai background color
      };
      
      input-field = {
        monitor = "";
        size = "200, 50";
        position = "0, -20";
        halign = "center";
        valign = "center";
        
        # Styling to match your Monokai theme
        outline_thickness = 2;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = true;
        dots_rounding = -1;
        outer_color = "rgba(117, 113, 94, 1)";  # Monokai comment color
        inner_color = "rgba(39, 40, 34, 1)";   # Monokai background
        font_color = "rgba(248, 248, 242, 1)";  # Monokai foreground
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        rounding = 4;
        check_color = "rgba(166, 226, 46, 1)";  # Monokai green
        fail_color = "rgba(249, 38, 114, 1)";   # Monokai red
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_timeout = 2000;
        fail_transitions = true;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;
      };
      
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%A, %B %-d')\"";
          color = "rgba(248, 248, 242, 1)";  # Monokai foreground
          font_size = 22;
          font_family = "NotoSansM Nerd Font Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%-I:%M')\"";
          color = "rgba(248, 248, 242, 1)";  # Monokai foreground
          font_size = 95;
          font_family = "NotoSansM Nerd Font Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
