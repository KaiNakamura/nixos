{ pkgs, ... }:

{

  home.packages = [ pkgs.gowall ];

  home.file.".config/gowall/config.yml".source = ./config.yml;
}
