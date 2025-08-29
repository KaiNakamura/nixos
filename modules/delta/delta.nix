{ pkgs, ... }:
{
  programs.delta = {
    enable = true;
  };

  # Integrate with Git
  programs.git = {
    extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      diff.colorMoved = "default";
      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
  };
}
