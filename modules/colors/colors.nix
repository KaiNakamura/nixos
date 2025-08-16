{ config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme = {
    slug = "monokai-kai";
    name = "Monokai Kai";
    author = "Kai Nakamura";
    colors = {
      white = "#f8f8f2";
      gray0 = "#88846f";
      gray1 = "#75715e";
      gray2 = "#414339";
      gray3 = "#272822";
      black = "#1e1f1c";
      red = "#f92672";
      dark_red = "#c4265e";
      orange = "#fd971f";
      dark_orange = "#cc6f04";
      yellow = "#e6db74";
      dark_yellow = "#b3b42b";
      green = "#a6e22e";
      dark_green = "#86b42b";
      cyan = "#66d9ef";
      dark_cyan = "#56adbc";
      blue = "#819aff";
      dark_blue = "#6a7ec8";
      purple = "#ae81ff";
      dark_purple = "#8c6bc8";
    };
  };
}
