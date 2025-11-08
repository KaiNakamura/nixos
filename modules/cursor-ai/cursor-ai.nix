{ pkgs, ... }:

let
  editorConfig = import ../vscode/editor-config.nix { inherit pkgs; };
  
  # Wrapper script to suppress harmless Electron warning about 'update' flag
  # TODO: Can maybe remove this in the future, would just remove this block and
  # swap `cursor-wrapper` for `code-cursor` below
  cursor-wrapper = pkgs.writeScriptBin "cursor" ''
    #!${pkgs.bash}/bin/bash
    exec ${pkgs.code-cursor}/bin/cursor "$@" 2> >(grep -v "Warning: 'update' is not in the list of known options" >&2)
  '';
in
{
  home.packages = with pkgs; [
    cursor-wrapper
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
        # Disable Cursor's default Ctrl+L for side panel toggle
        # This conflicts with vim window navigation
        {
          key = "ctrl+l";
          command = "-workbench.action.toggleSidebarVisibility";
        }
        {
          key = "ctrl+l";
          command = "-workbench.action.toggleAuxiliaryBar";
        }
        # Also disable any other Ctrl+L bindings that might interfere
        {
          key = "ctrl+l";
          command = "-workbench.action.focusActiveEditorGroup";
          when = "sideBarFocus || auxiliaryBarFocus";
        }
      ]
    );
  };
}
