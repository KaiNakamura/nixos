{ pkgs, ... }:

{
  home.packages = with pkgs; [
    uv
  ];

  home.sessionVariables = {
    # Set the Python preference to only managed
    # This means uv will download and manage Python versions itself
    UV_PYTHON_PREFERENCE = "only-managed";
  };
}

