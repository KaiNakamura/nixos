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

      # Leader-based navigation (Space = leader, works from editor)
      {
        key = "space j";
        command = "workbench.action.focusActiveEditorGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "space e";
        command = "workbench.view.explorer";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "space o";
        command = "workbench.panel.chat.view.copilot.focus";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "space t";
        command = "workbench.action.terminal.focus";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
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

      # File operations
      {
        key = "ctrl+o";
        command = "workbench.action.quickOpen";
      }
      {
        key = "ctrl+n";
        command = "explorer.newFile";
        when = "explorerViewletFocus";
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

      # Disable conflicting defaults for ctrl+o
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
    ];
  };
}
