{
  lib,
  stdenvNoCC,
  makeWrapper,
  hyprland,
  libnotify,
  rofi,
}:
stdenvNoCC.mkDerivation {
  pname = "misc-scripts";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    hyprland
    libnotify
    rofi
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/power-menu --prefix PATH : ${
      lib.makeBinPath [
        hyprland
        libnotify
        rofi
      ]
    }
  '';
}
