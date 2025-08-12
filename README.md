# NixOS

My NixOS configuration

## Installation

Clone this repo, then create a symlink inside `/etc/nixos`

```sh
sudo rm -rf /etc/nixos
sudo ln -s ~/repos/nixos /etc/nixos
```

## NixOS Cheat Sheet

To rebuild and activate the new generation immediately

```sh
sudo nixos-rebuild switch
```

To rebuild and activate with flakes

```sh
sudo nixos-rebuild switch --flake /etc/nixos#default
``` 

# NOTE: Flake builds only see committed files
# Uncommitted changes are ignored unless you use `--impure`
