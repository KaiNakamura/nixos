{ ... }:

{
  programs.vscode = {
    enable = true;
    userSettings = {
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.detectIndentation" = false;
      };
    };
  };
}
