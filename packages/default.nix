final: prev: {
  misc-scripts = prev.callPackage ./scripts/misc { };
  getpaper = prev.callPackage ./scripts/getpaper { };
  youtube = prev.callPackage ./scripts/youtube { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };
  caddy-hetzner = prev.callPackage ./caddy { };
}
