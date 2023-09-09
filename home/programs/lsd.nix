{pkgs, ...}: let
  dracula-lsd = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "lsd";
    rev = "75f3305a2bba4dacac82b143a15d278daee28232";
    hash = "sha256-ZNyNYJEffxxU7K/7JOv+VRD3JbhW42kvmWk7pLu1vA8=";
  };
in {
  xdg.configFile."lsd/themes/colors.yaml".source = "${dracula-lsd}/dracula.yaml";
  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      color = {
        when = "always";
        theme = "custom";
      };
      icons = {
        when = "always";
        theme = "fancy";
      };
      sorting = {
        dir-grouping = "first";
      };
      date = "relative";
    };
  };
}
