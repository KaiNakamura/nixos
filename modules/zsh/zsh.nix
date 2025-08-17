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
      # NixOS
      ns = "sudo nixos-rebuild switch --flake $NIXOS_FLAKE";
    };
    
    initContent = ''
      # Keybindings
      bindkey '^R' history-incremental-search-backward

      # Show system info (skip non-interactive or when NO_FASTFETCH set)
      if [[ -t 1 && -z "$NO_FASTFETCH" ]] && command -v fastfetch >/dev/null 2>&1; then
        fastfetch
      fi
    '';
  };
}
