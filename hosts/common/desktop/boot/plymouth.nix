{ lib, pkgs, ... }:
let
  theme = "hexagon_dots";
in
{
  boot.plymouth = {
    enable = true;
    themePackages = lib.mkDefault [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; })
    ];
    theme = lib.mkDefault theme;
  };
}
