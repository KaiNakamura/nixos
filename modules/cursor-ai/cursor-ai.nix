{ pkgs, lib, ... }:

let
  editorConfig = import ../vscode/editor-config.nix { inherit pkgs; };
  
  # Create symlinks for each extension so Cursor can find them
  # Cursor looks for extensions in ~/.cursor/extensions
  extensionLinks = lib.listToAttrs (map (ext: {
    name = ".cursor/extensions/${ext.vscodeExtUniqueId}";
    value = { source = "${ext}/share/vscode/extensions/${ext.vscodeExtUniqueId}"; };
  }) editorConfig.extensions);
in
{
  # Install Cursor IDE (available as code-cursor in nixpkgs)
  home.packages = with pkgs; [
    code-cursor
  ];

  # Cursor uses similar config structure to VS Code
  # Settings are stored in ~/.config/Cursor/User/settings.json
  # Keybindings are in ~/.config/Cursor/User/keybindings.json
  
  # Merge extension symlinks with config files
  home.file = extensionLinks // {
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
