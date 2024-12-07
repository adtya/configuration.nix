{ lib, pkgs, ... }:
let theme = "owl"; in {
  boot.plymouth = {
    enable = true;
    themePackages = lib.mkDefault [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; })
    ];
    theme = lib.mkDefault theme;
  };
}
