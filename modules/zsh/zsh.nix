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
      # Git
      gs = "git status";
      ga = "git add";
      gm = "git commit -m";
      gam = "git commit -am";
      gb = "git branch";
      gp = "git push";
      gpo = "git push origin";
      gc = "git checkout";
      gl = "git log";
      
      # Zoxide
      cd = "z";

      # NixOS
      ns = "sudo nixos-rebuild switch --flake $NIXOS_FLAKE";

      # Fastfetch
      ff = "fastfetch";
    };
    
    initContent = ''
      # Keybindings
      bindkey '^R' history-incremental-search-backward
    '';
  };
}
