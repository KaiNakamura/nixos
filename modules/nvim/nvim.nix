{ config, lib, pkgs, ... }:

let
  repoPath = "${config.home.homeDirectory}/repos/kai.nvim";
  repoUrl = "https://github.com/KaiNakamura/kai.nvim";
in {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      fd
      ripgrep
      gcc
      gnumake
      unzip
      wl-clipboard
      tree-sitter
    ];
  };

  # Clone/update the external editable repo before Home Manager links files
  home.activation.kaiNvim = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    set -e
    repo="${repoPath}"
    url="${repoUrl}"
    git="${pkgs.git}/bin/git"

    if [ ! -d "$repo/.git" ]; then
      mkdir -p "$(dirname "$repo")"
      echo "[kai.nvim] Cloning repository..."
      git clone --depth 1 "$url" "$repo" || echo "[kai.nvim] Clone failed"
    else
      cd "$repo"
      # Only update if clean
      if git diff --quiet && git diff --cached --quiet; then
        branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || echo main)"
        echo "[kai.nvim] Updating (branch $branch)..."
        git fetch --depth 1 origin "$branch" || true
        # Fast-forward only
        git merge --ff-only "origin/$branch" 2>/dev/null || true
      else
        echo "[kai.nvim] Local changes detected; skipping auto-update."
      fi
    fi
  '';

  # Symlink Neovim config to the editable repo working copy
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink repoPath;
}
