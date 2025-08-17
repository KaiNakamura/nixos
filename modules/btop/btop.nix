{ pkgs, config, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      truecolor = true;
      theme_background = false;
      color_theme = "kai";
      show_battery = true;
    };
  };

  home.file.".config/btop/themes/kai.theme".text = ''
    theme[main_bg]="#${config.colorScheme.palette.gray3}"
    theme[main_fg]="#${config.colorScheme.palette.white}"
    theme[title]="#${config.colorScheme.palette.white}"
    theme[hi_fg]="#${config.colorScheme.palette.red}"
    theme[selected_bg]="#${config.colorScheme.palette.gray2}"
    theme[selected_fg]="#${config.colorScheme.palette.white}"
    theme[inactive_fg]="#${config.colorScheme.palette.gray1}"
    theme[graph_text]="#${config.colorScheme.palette.white}"
    theme[graph_line]="#${config.colorScheme.palette.cyan}"
    theme[cpu_box]="#${config.colorScheme.palette.blue}"
    theme[mem_box]="#${config.colorScheme.palette.green}"
    theme[net_box]="#${config.colorScheme.palette.orange}"
    theme[proc_box]="#${config.colorScheme.palette.purple}"
    theme[div_line]="#${config.colorScheme.palette.gray2}"
    theme[proc_misc]="#${config.colorScheme.palette.yellow}"
    theme[bg_proc]="#${config.colorScheme.palette.gray2}"

    theme[temp_start]="#${config.colorScheme.palette.green}"
    theme[temp_mid]="#${config.colorScheme.palette.yellow}"
    theme[temp_end]="#${config.colorScheme.palette.red}"
    theme[free_start]="#${config.colorScheme.palette.green}"
    theme[free_mid]="#${config.colorScheme.palette.yellow}"
    theme[free_end]="#${config.colorScheme.palette.red}"
    theme[cached_start]="#${config.colorScheme.palette.cyan}"
    theme[cached_mid]="#${config.colorScheme.palette.blue}"
    theme[cached_end]="#${config.colorScheme.palette.purple}"

    theme[warning]="#${config.colorScheme.palette.orange}"
    theme[critical]="#${config.colorScheme.palette.red}"
  '';
}
