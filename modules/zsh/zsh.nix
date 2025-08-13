{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    # Set zsh as the default shell for this user
    shellAliases = {
      cd = "z";
    };
    
    initExtra = ''
      # Starship
      eval "$(starship init zsh)"
      
      # zoxide
      eval "$(zoxide init zsh)"
    '';
  };
}
