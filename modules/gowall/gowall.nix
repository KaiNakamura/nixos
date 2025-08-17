{ pkgs, config, ... }:

{
  home.packages = [ pkgs.gowall ];

  home.file.".config/gowall/config.yml".text = ''
    themes:
      - name: "kai"
        colors:
          - "#${config.colorScheme.palette.white}"
          - "#${config.colorScheme.palette.gray0}"
          - "#${config.colorScheme.palette.gray1}"
          - "#${config.colorScheme.palette.gray2}"
          - "#${config.colorScheme.palette.gray3}"
          - "#${config.colorScheme.palette.black}"
          - "#${config.colorScheme.palette.red}"
          - "#${config.colorScheme.palette.dark_red}"
          - "#${config.colorScheme.palette.orange}"
          - "#${config.colorScheme.palette.dark_orange}"
          - "#${config.colorScheme.palette.yellow}"
          - "#${config.colorScheme.palette.dark_yellow}"
          - "#${config.colorScheme.palette.green}"
          - "#${config.colorScheme.palette.dark_green}"
          - "#${config.colorScheme.palette.cyan}"
          - "#${config.colorScheme.palette.dark_cyan}"
          - "#${config.colorScheme.palette.blue}"
          - "#${config.colorScheme.palette.dark_blue}"
          - "#${config.colorScheme.palette.purple}"
          - "#${config.colorScheme.palette.dark_purple}"
  '';
}
