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
      # ============================================
      # CURSOR-SPECIFIC DISABLES - Must come first
      # Additional disables beyond shared config
      # ============================================
      
      # Cursor-specific AI chat commands bound to Ctrl+L
      # These must be disabled before shared keybindings are processed
      [
        {
          key = "ctrl+l";
          command = "-aichat.focus";
        }
        {
          key = "ctrl+l";
          command = "-aichat.toggle";
        }
        {
          key = "ctrl+l";
          command = "-aichat.newchataction";
        }
      ]

      # Add shared keybindings (includes all disables and active bindings)
      ++ editorConfig.keybindings

      # ============================================
      # CURSOR-SPECIFIC ADDITIONS
      # ============================================
      ++ [
        # AI Chat - Focus/Open chat panel
        {
          key = "space o";
          command = "aichat.newchataction";
          when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
        }
        
        # ============================================
        # CURSOR AI CHAT - Chat Panel Navigation
        # These only work when chat panel is focused (not in editor)
        # Note: Command IDs may need verification in Cursor's command palette
        # ============================================
        
        # Chat navigation - Move between chats
        {
          key = "alt+h";
          command = "aichat.previousChat";
          when = "aichatFocus && !aichatInputFocus";
        }
        {
          key = "alt+l";
          command = "aichat.nextChat";
          when = "aichatFocus && !aichatInputFocus";
        }
        
        # Chat management - Close current chat
        {
          key = "alt+q";
          command = "aichat.closeChat";
          when = "aichatFocus && !aichatInputFocus";
        }
        
        # Mode switching - Agent/Ask/Plan modes
        {
          key = "alt+a";
          command = "aichat.agentMode";
          when = "aichatFocus && !aichatInputFocus";
        }
        {
          key = "alt+s";
          command = "aichat.askMode";
          when = "aichatFocus && !aichatInputFocus";
        }
        {
          key = "alt+p";
          command = "aichat.planMode";
          when = "aichatFocus && !aichatInputFocus";
        }
        
        # Scrolling - Works in both chat panel and input
        {
          key = "ctrl+u";
          command = "scrollPageUp";
          when = "aichatFocus || aichatInputFocus";
        }
        {
          key = "ctrl+d";
          command = "scrollPageDown";
          when = "aichatFocus || aichatInputFocus";
        }
      ]
    );
  };
}
