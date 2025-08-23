{ config, pkgs, ... }:

{
  imports = [
    # Theming and appearance
    ../modules/colors/colors.nix
    ../modules/fonts/fonts.nix
    
    # Shell environment
    ../modules/zsh/zsh.nix
    ../modules/starship/starship.nix
    ../modules/zoxide/zoxide.nix
    ../modules/eza/eza.nix
    
    # Basic tools
    ../modules/git/git.nix
    ../modules/vim/vim.nix
    ../modules/nvim/nvim.nix
    ../modules/btop/btop.nix
    ../modules/fastfetch/fastfetch.nix
    
    # Container tools
    # NOTE: Docker needs to be enabled system-level so it's not included here
    ../modules/lazydocker/lazydocker.nix
  ];
}
