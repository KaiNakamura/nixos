{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "NotoSansM Nerd Font Mono";
      size = 12;
    };
    settings = {
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      
      # Monokai theme
      background = "#272822";
      foreground = "#f8f8f2";
      cursor = "#f8f8f2";
      selection_background = "#f8f8f2";
      selection_foreground = "#272822";
      active_tab_background = "#75715e";
      active_tab_foreground = "#272822";
      active_border_color = "#75715e";
      inactive_tab_background = "#272822";
      inactive_tab_foreground = "#75715e";
      inactive_border_color = "#75715e";
      url_color = "#f8f8f2";
      
      # 16 Color Space
      color0 = "#272822";
      color8 = "#75715e";
      color1 = "#f92672";
      color9 = "#f92672";
      color2 = "#a6e22e";
      color10 = "#a6e22e";
      color3 = "#e6db74";
      color11 = "#e6db74";
      color4 = "#66d9ef";
      color12 = "#66d9ef";
      color5 = "#fd971f";
      color13 = "#fd971f";
      color6 = "#ae81ff";
      color14 = "#ae81ff";
      color7 = "#f8f8f2";
      color15 = "#f8f8f2";
      
      # Behavior
      enabled_layouts = "splits";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";
    };
    keybindings = {
      # Splits
      "ctrl+shift+s" = "launch --location=split --cwd=current";
      "ctrl+shift+i" = "launch --location=vsplit --cwd=current";
      "ctrl+shift+o" = "launch --location=hsplit --cwd=current";
      
      # Close window
      "ctrl+shift+q" = "close_window";
      
      # Move between windows
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+l" = "neighboring_window right";
      
      # Switch tabs
      "alt+shift+n" = "new_tab";
      "alt+shift+q" = "close_tab";
      "alt+shift+l" = "next_tab";
      "alt+shift+h" = "previous_tab";
      "alt+shift+1" = "goto_tab 1";
      "alt+shift+2" = "goto_tab 2";
      "alt+shift+3" = "goto_tab 3";
      "alt+shift+4" = "goto_tab 4";
      "alt+shift+5" = "goto_tab 5";
      "alt+shift+6" = "goto_tab 6";
      "alt+shift+7" = "goto_tab 7";
      "alt+shift+8" = "goto_tab 8";
      "alt+shift+9" = "goto_tab 9";
    };
    extraConfig = ''
      # kitty-scrollback.nvim Kitten alias
      action_alias kitty_scrollback_nvim kitten ~/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py
      
      # Browse scrollback buffer in nvim
      map alt+shift+f kitty_scrollback_nvim
      # Browse output of the last shell command in nvim
      map alt+shift+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
      # Show clicked command output in nvim
      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';
  };
}
