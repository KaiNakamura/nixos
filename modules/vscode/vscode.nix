{ ... }:

{
  programs.vscode = {
    enable = true;
    userSettings = {
      # Use Noto Nerd Font for editor to see icons properly
      "editor.fontFamily" = "'Noto Sans Mono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
      
      # Terminal font (also useful for integrated terminal)
      "terminal.integrated.fontFamily" = "'Noto Sans Mono Nerd Font'";
      "terminal.integrated.fontSize" = 14;
    };
  };
}
