# NixOS

My NixOS configuration.

## Installation

Clone this repo, then create a symlink inside `/etc/nixos`

```sh
sudo rm -rf /etc/nixos
sudo ln -s ~/repos/nixos /etc/nixos
```

## Building

To rebuild and activate with flakes

```sh
sudo nixos-rebuild switch --flake /etc/nixos#default
```

**Note**: Flake builds only see committed files. Uncommitted changes are ignored unless you use `--impure`.

```sh
sudo nixos-rebuild switch --flake /etc/nixos#default --impure
```
