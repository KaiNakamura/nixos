{ config, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    
    style = ''
      window {
        margin: 0px;
        border: 2px solid #${config.colorScheme.palette.gray1};
        background-color: #${config.colorScheme.palette.gray3};
        border-radius: 8px;
        font-family: "NotoSansM Nerd Font Mono";
        font-size: 14px;
        opacity: 0.95;
      }

      #input {
        margin: 8px;
        padding: 8px 12px;
        border: 1px solid #${config.colorScheme.palette.gray1};
        background-color: #${config.colorScheme.palette.gray2};
        color: #${config.colorScheme.palette.white};
        border-radius: 4px;
        font-size: 14px;
      }

      #input:focus {
        border: 1px solid #${config.colorScheme.palette.cyan};
        outline: none;
      }

      #inner-box {
        margin: 8px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 4px;
        border: none;
        color: #${config.colorScheme.palette.white};
        font-size: 14px;
      }

      #entry {
        padding: 8px;
        margin: 2px;
        border: none;
        background-color: transparent;
        border-radius: 4px;
      }

      #entry:selected {
        background-color: #${config.colorScheme.palette.gray2};
        border: 1px solid #${config.colorScheme.palette.cyan};
      }

      #entry:hover {
        background-color: #${config.colorScheme.palette.gray1};
      }

      #entry img {
        margin-right: 8px;
      }

      #entry:selected #text {
        color: #${config.colorScheme.palette.cyan};
        font-weight: bold;
      }
    '';
  };
}