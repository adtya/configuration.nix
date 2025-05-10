_final: prev: {
  misc-scripts = prev.callPackage ./scripts/misc { };
  getpaper = prev.callPackage ./scripts/getpaper { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };
}
