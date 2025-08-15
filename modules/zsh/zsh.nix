{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # Git
      gs = "git status";
      ga = "git add";
      gm = "git commit -m";
      gma = "git commit -ma";
      gb = "git branch";
      gp = "git push";
      gpo = "git push origin";
      gc = "git checkout";
      gl = "git log";
      
      # Zoxide
      cd = "z";

      # NixOS
      ns = "sudo nixos-rebuild switch --flake $NIXOS_FLAKE";
    };
    
    initContent = ''
      # Environment variables
      export NIXOS_FLAKE="/etc/nixos#default"

      # Keybindings
      bindkey '^R' history-incremental-search-backward

      # Starship
      eval "$(starship init zsh)"
      
      # zoxide
      eval "$(zoxide init zsh)"
    '';
  };
}
