{ ... }:

{
  programs.gowall = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/gowall/config.yml".source = ./config.yml;
}
