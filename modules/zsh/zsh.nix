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
      # NixOS rebuild function with optional target argument
      ns() {
        local target
        
        if [[ $# -eq 0 ]]; then
          # If no target specified, use hostname
          target="$(hostname)"
          echo "Using hostname as target: $target"
        else
          # Otherwise, use provided target
          target="$1"
          shift  # Remove target from arguments, pass the rest to nixos-rebuild
        fi
        
        sudo nixos-rebuild switch --flake "/etc/nixos#$target" "$@"
      }
      
      # Search command history with Ctrl+R
      bindkey '^R' history-incremental-search-backward

      # Accept autosuggestion with Alt+l
      bindkey '^[l' autosuggest-accept

      # Accept and execute autosuggestion with Alt+Enter
      bindkey "\e\r" autosuggest-execute
    '';
  };
}
