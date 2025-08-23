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
      # Automatically uses hostname as flake target
      ns = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
    };
    
    initContent = ''
      # Keybindings
      bindkey '^R' history-incremental-search-backward
    '';
  };
}
