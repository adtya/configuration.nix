pkgs: {
  dracula-gtk = pkgs.callPackage ./dracula-gtk { };
  misc-scripts = pkgs.callPackage ./scripts/misc { };
  getpaper = pkgs.callPackage ./scripts/getpaper { };
  youtube = pkgs.callPackage ./scripts/youtube { };
  rofi-bluetooth = pkgs.callPackage ./rofi-bluetooth { };
  smc-manjari = pkgs.callPackage ./smc-manjari { };
  smc-nupuram = pkgs.callPackage ./smc-nupuram { };
}
