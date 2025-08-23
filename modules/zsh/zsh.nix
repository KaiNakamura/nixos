{ pkgs, ... }:

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
      # NixOS rebuild function with target argument
      ns() {
        if [[ $# -eq 0 ]]; then
          echo "Usage: ns <target>"
          return 1
        fi
        
        local target="$1"
        shift  # Remove target from arguments, pass the rest to nixos-rebuild
        
        sudo nixos-rebuild switch --flake "/etc/nixos#$target" "$@"
      }
      
      # Keybindings
      bindkey '^R' history-incremental-search-backward
    '';
  };
}
