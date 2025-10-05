{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    
    # Core extensions managed by Nix
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Vim
      vscodevim.vim

      # Nix
      bbenoist.nix

      # Copilot
      github.copilot
      github.copilot-chat

      # Additional Niceties
      mhutchie.git-graph
      vscode-icons-team.vscode-icons

      # Remote Development
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-containers

      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-python.black-formatter
      ms-python.isort
      ms-python.debugpy

      # C / C++
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cmake-tools
      twxs.cmake

      # Docker & Kubernetes
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools

      # YAML
      redhat.vscode-yaml

      # Prettier
      esbenp.prettier-vscode
    ];

    # Allow installing additional extensions via UI
    mutableExtensionsDir = true;

    # User settings
    profiles.default.userSettings = {
      # Editor
      "editor.acceptSuggestionOnCommitCharacter" = false;
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.codeLens" = false;
      "editor.fontSize" = 18;
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      "editor.minimap.autohide" = "mouseover";
      "editor.suggestSelection" = "first";
      "editor.wordWrap" = "on";

      # Vim
      "vim.useSystemClipboard" = true;
      "vim.vimrc.enable" = true;
      "vim.leader" = " ";
      "vim.handleKeys" = {
        "<C-d>" = true;
        "<C-s>" = false;
        "<C-z>" = false;
        "<C-w>" = false;
      };
      "vim.digraphs" = {};

      # Workbench / Appearance
      "workbench.colorTheme" = "Monokai";
      "workbench.iconTheme" = "vscode-icons";
      "workbench.startupEditor" = "newUntitledFile";
      "window.confirmSaveUntitledWorkspace" = false;
      "explorer.confirmDelete" = false;
      "vsicons.dontShowNewVersionMessage" = true;

      # GitHub Copilot
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = false;
        "markdown" = true;
        "scminput" = false;
      };
      "github.copilot.nextEditSuggestions.enabled" = true;

      # Python
      "python.languageServer" = "Default";
      "python.showStartPage" = false;
      "python.analysis.typeCheckingMode" = "standard";

      # CMake
      "cmake.showOptionsMovedNotification" = false;
      "cmake.pinnedCommands" = [
        "workbench.action.tasks.configureTaskRunner"
        "workbench.action.tasks.runTask"
      ];

      # Terminal
      "terminal.integrated.enableMultiLinePasteWarning" = "never";

      # JavaScript/TypeScript
      "typescript.updateImportsOnFileMove.enabled" = "always";

      # Prettier
      "prettier.bracketSameLine" = true;

      # Red Hat
      "redhat.telemetry.enabled" = false;

      # Language-specific settings
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.detectIndentation" = false;
      };

      "[python]" = {
        "editor.formatOnType" = true;
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.tabSize" = 4;
      };

      "[cpp]" = {
        "editor.defaultFormatter" = "ms-vscode.cpptools";
      };

      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "[json]" = {
        "editor.quickSuggestions" = {
          "strings" = true;
        };
        "editor.suggest.insertMode" = "replace";
      };
    };

    # Keybindings
    profiles.default.keybindings = [
      # Return to Editor - Multiple Ways
      {
        key = "escape";
        command = "workbench.action.focusActiveEditorGroup";
        when = "!editorTextFocus";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.focusActiveEditorGroup";
        when = "sideBarFocus";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.focusActiveEditorGroup";
        when = "panelFocus || auxiliaryBarFocus";
      }

      # Leader-based navigation (Space = leader)
      # Works in editor (Vim Normal mode) and sidebars/panels, but NOT in text input fields
      {
        key = "space e";
        command = "workbench.view.explorer";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
      {
        key = "space o";
        command = "workbench.panel.chat.view.copilot.focus";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
      {
        key = "space t";
        command = "workbench.action.terminal.focus";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
      # Additional leader shortcuts
      {
        key = "space s f";
        command = "workbench.action.quickOpen";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
      {
        key = "space s g";
        command = "workbench.action.findInFiles";
        when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
      }
 
      # Disable default Ctrl+W and Alt+Q behavior first (prevent closing entire window)
      {
        key = "ctrl+w";
        command = "-workbench.action.closeWindow";
      }
      {
        key = "ctrl+w";
        command = "-workbench.action.closeEditorsInGroup";
      }
      {
        key = "ctrl+w";
        command = "-workbench.action.closeGroup";
      }
      {
        key = "ctrl+w";
        command = "-workbench.action.closeActiveEditor";
      }
      {
        key = "ctrl+w";
        command = "-workbench.action.closeEditor";
      }
      {
        key = "alt+q";
        command = "-workbench.action.closeWindow";
      }
      {
        key = "ctrl+q";
        command = "-workbench.action.quit";
      }
      {
        key = "ctrl+q";
        command = "-workbench.action.closeWindow";
      }

      # Close/hide focused panel or sidebar (Ctrl+Q)
      {
        key = "ctrl+q";
        command = "workbench.action.toggleSidebarVisibility";
        when = "sideBarFocus";
      }
      {
        key = "ctrl+q";
        command = "workbench.action.closePanel";
        when = "panelFocus";
      }
      {
        key = "ctrl+q";
        command = "workbench.action.closeAuxiliaryBar";
        when = "auxiliaryBarFocus";
      }
      {
        key = "ctrl+q";
        command = "workbench.action.closeActiveEditor";
        when = "editorFocus";
      }

      # Resize sidebar and panels (Ctrl+Arrow) - Directional
      # Sidebar (left): Right arrow increases, Left arrow decreases
      {
        key = "ctrl+right";
        command = "workbench.action.increaseViewSize";
        when = "sideBarFocus";
      }
      {
        key = "ctrl+left";
        command = "workbench.action.decreaseViewSize";
        when = "sideBarFocus";
      }
      # Panel (bottom): Down arrow increases, Up arrow decreases
      {
        key = "ctrl+down";
        command = "workbench.action.increaseViewSize";
        when = "panelFocus";
      }
      {
        key = "ctrl+up";
        command = "workbench.action.decreaseViewSize";
        when = "panelFocus";
      }
      # Auxiliary bar (right, e.g., Copilot): Left arrow increases, Right arrow decreases
      {
        key = "ctrl+left";
        command = "workbench.action.increaseViewSize";
        when = "auxiliaryBarFocus";
      }
      {
        key = "ctrl+right";
        command = "workbench.action.decreaseViewSize";
        when = "auxiliaryBarFocus";
      }

      # Disable default Ctrl+Arrow behavior
      {
        key = "ctrl+left";
        command = "-cursorWordLeft";
        when = "textInputFocus";
      }
      {
        key = "ctrl+right";
        command = "-cursorWordRight";
        when = "textInputFocus";
      }
      {
        key = "ctrl+up";
        command = "-scrollLineUp";
        when = "textInputFocus";
      }
      {
        key = "ctrl+down";
        command = "-scrollLineDown";
        when = "textInputFocus";
      }

      # Tab navigation
      {
        key = "alt+l";
        command = "workbench.action.nextEditor";
      }
      {
        key = "alt+h";
        command = "workbench.action.previousEditor";
      }
      {
        key = "alt+q";
        command = "workbench.action.closeActiveEditor";
      }

      # Split operations
      {
        key = "ctrl+i";
        command = "workbench.action.splitEditorDown";
        when = "editorFocus";
      }
      {
        key = "ctrl+o";
        command = "workbench.action.splitEditorRight";
        when = "editorFocus";
      }

      # File operations
      {
        key = "ctrl+n";
        command = "explorer.newFile";
        when = "explorerViewletFocus";
      }

      # Explorer operations
      {
        key = "shift+w";
        command = "list.collapseAll";
        when = "explorerViewletFocus && filesExplorerFocus";
      }

      # Disable conflicting defaults for alt+h/l
      {
        key = "alt+h";
        command = "-testing.toggleTestingPeekHistory";
        when = "testing.isPeekVisible";
      }
      {
        key = "alt+l";
        command = "-toggleSearchEditorContextLines";
        when = "inSearchEditor";
      }
      {
        key = "alt+l";
        command = "-toggleFindInSelection";
        when = "editorFocus";
      }

      # Disable conflicting defaults for ctrl+o and ctrl+i
      {
        key = "ctrl+o";
        command = "-workbench.action.files.openFile";
      }
      {
        key = "ctrl+o";
        command = "-workbench.action.files.openFolderViaWorkspace";
        when = "!openFolderWorkspaceSupport && workbenchState == 'workspace'";
      }
      {
        key = "ctrl+o";
        command = "-workbench.action.files.openFileFolder";
        when = "isMacNative && openFolderWorkspaceSupport";
      }
      {
        key = "ctrl+o";
        command = "-extension.vim_ctrl+o";
        when = "editorTextFocus && vim.active && vim.use<C-o> && !inDebugRepl";
      }
      {
        key = "ctrl+i";
        command = "-extension.vim_ctrl+i";
        when = "editorTextFocus && vim.active && vim.use<C-i> && !inDebugRepl";
      }
    ];
  };
}
