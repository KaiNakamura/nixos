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
        # Disable Alt+S menu command that conflicts with Ask mode
        {
          key = "alt+s";
          command = "-workbench.action.showEditorMenu";
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
          command = "cursor.chat.previousChat";
          when = "activeChatPanel || aichatFocus";
        }
        {
          key = "alt+l";
          command = "cursor.chat.nextChat";
          when = "activeChatPanel || aichatFocus";
        }
        
        # Chat management - Close current chat
        {
          key = "alt+q";
          command = "cursor.chat.closeChat";
          when = "activeChatPanel || aichatFocus";
        }
        
        # Mode switching - Agent/Ask/Plan modes
        {
          key = "alt+a";
          command = "cursor.chat.agentMode";
          when = "activeChatPanel || aichatFocus";
        }
        {
          key = "alt+s";
          command = "cursor.chat.askMode";
          when = "activeChatPanel || aichatFocus";
        }
        {
          key = "alt+p";
          command = "cursor.chat.planMode";
          when = "activeChatPanel || aichatFocus";
        }
        
        # Scrolling - Works in both chat panel and input
        # These use standard VS Code scroll commands
        {
          key = "ctrl+u";
          command = "scrollPageUp";
          when = "activeChatPanel || aichatFocus || aichatInputFocus";
        }
        {
          key = "ctrl+d";
          command = "scrollPageDown";
          when = "activeChatPanel || aichatFocus || aichatInputFocus";
        }
      ]
    );
  };
}
