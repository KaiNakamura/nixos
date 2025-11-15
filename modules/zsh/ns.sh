#!/usr/bin/env bash
# Unified NixOS/Home Manager switch function with target persistence

ns() {
  # Determine flake path
  local flake_path
  if [ -d /etc/nixos ]; then
    flake_path="/etc/nixos"
  else
    flake_path="$HOME/repos/nixos"
  fi
  
  # XDG-compliant config location
  local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nix"
  local target_file="$config_dir/target"
  local target="${1:-}"
  
  mkdir -p "$config_dir"
  
  # Helper to list available targets
  list_targets() {
    echo "Available targets:"
    nix flake show "$flake_path" --json 2>/dev/null | \
      jq -r '(.nixosConfigurations // {}) + (.homeConfigurations // {}) | keys[]' 2>/dev/null | \
      nl -w2 -s') ' || echo "  (unable to list - run 'nix flake show' manually)"
  }
  
  # If target provided, use and save it
  if [ -n "$target" ]; then
    echo "$target" > "$target_file"
    echo "Saved target: $target"
  # Otherwise, try to load from file
  elif [ -f "$target_file" ]; then
    target=$(cat "$target_file" | tr -d '\n')
  # No target found - interactive selection
  else
    echo "No target configured."
    echo ""
    list_targets
    echo ""
    read -p "Enter target name: " target
    if [ -z "$target" ]; then
      echo "No target specified. Exiting."
      return 1
    fi
    echo "$target" > "$target_file"
    echo "Saved target: $target"
  fi
  
  # Determine command type and execute
  if nix flake show "$flake_path" --json 2>/dev/null | \
     jq -e ".nixosConfigurations.\"$target\"" >/dev/null 2>&1; then
    sudo nixos-rebuild switch --flake "$flake_path#$target" "${@:2}"
  else
    home-manager switch --flake "$flake_path#$target" "${@:2}"
  fi
}

