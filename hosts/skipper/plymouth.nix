{ lib, pkgs, ... }: {
  boot.plymouth = let theme = "dark_planet"; in {
    enable = true;
    themePackages = lib.mkDefault [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; })
    ];
    theme = lib.mkDefault theme;
  };
}
