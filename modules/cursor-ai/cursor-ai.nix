{ pkgs, ... }:

let
  editorConfig = import ../vscode/editor-config.nix { inherit pkgs; };
in
{
  # Install Cursor IDE (available as code-cursor in nixpkgs)
  home.packages = with pkgs; [
    code-cursor
  ];

  # Cursor uses similar config structure to VS Code
  # Settings are stored in ~/.config/Cursor/User/settings.json
  # Keybindings are in ~/.config/Cursor/User/keybindings.json
  
  # Note: Cursor has its own extension marketplace (compatible with VS Code extensions)
  # Extensions should be installed through Cursor's Extensions panel
  # The same extension IDs from VS Code will work in Cursor
  
  home.file = {
    # Apply shared editor configuration with Cursor-specific overrides
    ".config/Cursor/User/settings.json".text = builtins.toJSON (
      editorConfig.settings // {
        # Cursor AI-specific settings
        "cursor.ai.enabled" = true;
        "cursor.chat.enabled" = true;
        "cursor.cpp.disabledLanguages" = [];
      }
    );

    ".config/Cursor/User/keybindings.json".text = builtins.toJSON (
      editorConfig.keybindings ++ [
        # Cursor-specific: Space+O for AI chat
        {
          key = "space o";
          command = "aichat.newchataction";
          when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
        }
      ]
    );
  };
}
