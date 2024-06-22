final: prev: {
  dracula-gtk = prev.callPackage ./dracula-gtk { };
  misc-scripts = prev.callPackage ./scripts/misc { };
  getpaper = prev.callPackage ./scripts/getpaper { };
  youtube = prev.callPackage ./scripts/youtube { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-manjari = prev.callPackage ./smc-manjari { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };
}
