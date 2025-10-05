{ pkgs, ... }:

let
  editorConfig = import ./editor-config.nix { inherit pkgs; };
in
{
  programs.vscode = {
    enable = true;
    
    # Core extensions from shared config
    profiles.default.extensions = editorConfig.extensions;

    # Allow installing additional extensions via UI
    mutableExtensionsDir = true;

    # User settings from shared config
    profiles.default.userSettings = editorConfig.settings;

    # Keybindings (shared config + VS Code-specific keybindings)
    profiles.default.keybindings = editorConfig.keybindings ++ [
      # VS Code-specific: Space+O for Copilot chat
      {
        key = "space o";
        command = "workbench.panel.chat.view.copilot.focus";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
    ];
  };
}
