# Shared configuration for VS Code-based editors (VS Code, Cursor, etc.)
{ pkgs }:

{
  extensions = with pkgs.vscode-extensions; [
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

  settings = {
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
    "vim.timeout" = 300;
    "vim.handleKeys" = {
      # Leader key
      "<space>" = false;
      
      # Window navigation
      "<C-h>" = false;
      "<C-j>" = false;
      "<C-k>" = false;
      "<C-l>" = false;
      "<C-w>" = false;
      
      # Terminal/System operations
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

  keybindings = [
    # ============================================
    # DISABLES - All Default Conflicts
    # Must come first as keybindings are processed in order
    # ============================================
    
    
    # Ctrl+W disables
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
    
    # Ctrl+Q disables
    {
      key = "ctrl+q";
      command = "-workbench.action.quit";
    }
    {
      key = "ctrl+q";
      command = "-workbench.action.closeWindow";
    }
    
    # Alt+Q disables
    {
      key = "alt+q";
      command = "-workbench.action.closeWindow";
    }
    
    # Alt+H/L disables
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
    
    # Ctrl+O/I disables
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

    # ============================================
    # GLOBAL NAVIGATION - Works from anywhere
    # ============================================
    
    # Escape - Universal return to editor
    {
      key = "escape";
      command = "workbench.action.focusActiveEditorGroup";
      when = "!editorTextFocus || sideBarFocus || panelFocus || auxiliaryBarFocus";
    }
    
    # Leader bindings (Space = leader) - Panel navigation
    # Only active when not in insert mode or input fields
    {
      key = "space e";
      command = "workbench.view.explorer";
      when = "!inputFocus || (editorTextFocus && vim.active && vims.mode != 'Insert')";
    }
    {
      key = "space t";
      command = "workbench.action.terminal.focus";
      when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
    }
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
    {
      key = "space p";
      command = "workbench.actions.view.problems";
      when = "!inputFocus || (editorTextFocus && vim.active && vim.mode != 'Insert')";
    }

    # ============================================
    # EDITOR CONTEXT - When editor is focused
    # ============================================
    
    # Split operations - Create editor splits
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
    
    # Tab navigation - Switch between editor tabs
    {
      key = "alt+h";
      command = "workbench.action.previousEditor";
    }
    {
      key = "alt+l";
      command = "workbench.action.nextEditor";
    }
    {
      key = "alt+q";
      command = "workbench.action.closeActiveEditor";
    }
    
    # Font zoom - Adjust editor font size
    {
      key = "ctrl+shift+=";
      command = "editor.action.fontZoomIn";
    }
    {
      key = "ctrl+shift+-";
      command = "editor.action.fontZoomOut";
    }

    # ============================================
    # PANEL/SIDEBAR CONTEXT - When panels/sidebars are focused
    # ============================================
    
    # Close operations - Context-dependent close (sidebar/panel/editor)
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
    
    # Resize operations - Adjust panel/sidebar size
    {
      key = "ctrl+=";
      command = "workbench.action.increaseViewSize";
      when = "sideBarFocus || panelFocus || auxiliaryBarFocus";
    }
    {
      key = "ctrl+-";
      command = "workbench.action.decreaseViewSize";
      when = "sideBarFocus || panelFocus || auxiliaryBarFocus";
    }

    # ============================================
    # EXPLORER CONTEXT - When file explorer is focused
    # ============================================
    
    # File operations - Create, delete, rename files
    {
      key = "ctrl+n";
      command = "explorer.newFile";
      when = "explorerViewletFocus";
    }
    {
      key = "shift+w";
      command = "list.collapseAll";
      when = "explorerViewletFocus && filesExplorerFocus";
    }
    {
      key = "d";
      command = "deleteFile";
      when = "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus";
    }
    {
      key = "r";
      command = "renameFile";
      when = "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus";
    }
  ];
}
