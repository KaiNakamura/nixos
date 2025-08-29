{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    # Search hidden files, but ignore .git directories
    arguments = [ "--hidden" "--glob" "!.git" ];
  };
}
