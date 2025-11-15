{ pkgs, ... }:

let
  nsScript = builtins.readFile ./ns.sh;
in

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    
    shellAliases = {
      # Other aliases can go here
    };
    
    initContent = ''
      # Source scripts
      ${nsScript}
      
      # Search command history with Ctrl+R
      bindkey '^R' history-incremental-search-backward

      # Delete word backwards with Ctrl+Backspace
      bindkey '^H' backward-kill-word
    '';
  };
}
