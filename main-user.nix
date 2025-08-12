# TODO: Probably delete this file (created it while following a tutorial but it seems kind of unnecessary)

{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable
      = lib.mkEnableOption "enable user module";
    
    userName = lib.mkOption {
      default = "kai";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      shell = pkgs.zsh;
    };
  };
}
