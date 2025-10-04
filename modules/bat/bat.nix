{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
  };

  programs.zsh.shellAliases = {
    # Remove decorations and disable pager, this is useful for things that
    # expect `cat` to behave like `cat`.
    cat = "bat --style plain --pager never";
  };
}
