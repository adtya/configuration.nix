_final: prev: {
  misc-scripts = prev.callPackage ./scripts/misc { };
  getpaper = prev.callPackage ./scripts/getpaper { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };

  # package overrides
  gamemode = prev.gamemode.overrideAttrs (_oldAttrs: {
    version = "2025-09-04";
    src = prev.fetchFromGitHub {
      owner = "FeralInteractive";
      repo = "gamemode";
      rev = "f0a569a5199974751a4a75ebdc41c8f0b8e4c909";
      hash = "sha256-9DB8iWiyrM4EJ94ERC5SE9acrhqeI00BF1wU0umeNFg=";
    };
  });

  caddy-custom = prev.caddy.withPlugins {
    plugins = [ "github.com/caddy-dns/hetzner@v1.0.0" ];
    hash = "sha256-KNKmbZ65NwbEbseo5S3O0HzKseJkm4ZPugNOjMai02s=";
  };
}
