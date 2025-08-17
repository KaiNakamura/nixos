{ config, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "NotoSansM Nerd Font Mono";
      size = 12;
    };
    settings = {
      background_opacity = "0.5";
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      
      # Monokai theme
      background = "#${config.colorScheme.palette.gray3}";
      foreground = "#${config.colorScheme.palette.white}";
      cursor = "#${config.colorScheme.palette.white}";
      selection_background = "#${config.colorScheme.palette.white}";
      selection_foreground = "#${config.colorScheme.palette.gray3}";
      active_tab_background = "#${config.colorScheme.palette.gray1}";
      active_tab_foreground = "#${config.colorScheme.palette.gray3}";
      active_border_color = "#${config.colorScheme.palette.gray1}";
      inactive_tab_background = "#${config.colorScheme.palette.gray3}";
      inactive_tab_foreground = "#${config.colorScheme.palette.gray1}";
      inactive_border_color = "#${config.colorScheme.palette.gray1}";
      url_color = "#${config.colorScheme.palette.white}";
      
      # 16 Color Space
      color0 = "#${config.colorScheme.palette.gray3}";
      color8 = "#${config.colorScheme.palette.gray1}";
      color1 = "#${config.colorScheme.palette.red}";
      color9 = "#${config.colorScheme.palette.red}";
      color2 = "#${config.colorScheme.palette.green}";
      color10 = "#${config.colorScheme.palette.green}";
      color3 = "#${config.colorScheme.palette.yellow}";
      color11 = "#${config.colorScheme.palette.yellow}";
      color4 = "#${config.colorScheme.palette.cyan}";
      color12 = "#${config.colorScheme.palette.cyan}";
      color5 = "#${config.colorScheme.palette.orange}";
      color13 = "#${config.colorScheme.palette.orange}";
      color6 = "#${config.colorScheme.palette.purple}";
      color14 = "#${config.colorScheme.palette.purple}";
      color7 = "#${config.colorScheme.palette.white}";
      color15 = "#${config.colorScheme.palette.white}";
      
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
