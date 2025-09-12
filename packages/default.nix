_final: prev: {
  misc-scripts = prev.callPackage ./scripts/misc { };
  getpaper = prev.callPackage ./scripts/getpaper { };
  rofi-bluetooth = prev.callPackage ./rofi-bluetooth { };
  smc-nupuram = prev.callPackage ./smc-nupuram { };

  # package overrides
  btop = prev.btop.overrideAttrs (_oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "aristocratos";
      repo = "btop";
      rev = "bdddfc46a2bbfe4ba70c7fba4fbb30978d61dab9";
      hash = "sha256-2SGQLSyGMg3Fv10ewu8b64Z08fBbAkVCvEj2+0GGrHI=";
    };
  });
  gamemode = prev.gamemode.overrideAttrs (_oldAttrs: {
    version = "2025-09-04";
    src = prev.fetchFromGitHub {
      owner = "FeralInteractive";
      repo = "gamemode";
      rev = "f0a569a5199974751a4a75ebdc41c8f0b8e4c909";
      hash = "sha256-9DB8iWiyrM4EJ94ERC5SE9acrhqeI00BF1wU0umeNFg=";
    };
  });
}
