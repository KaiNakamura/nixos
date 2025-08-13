{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      cd = "z";
    };
    
    initContent = ''
      # Starship
      eval "$(starship init zsh)"
      
      # zoxide
      eval "$(zoxide init zsh)"
    '';
  };
  
  # Set zsh as the default shell for this user
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
}
