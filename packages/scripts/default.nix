{ lib, stdenvNoCC, makeWrapper, libnotify, rofi-wayland, power-profiles-daemon }:

stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ libnotify rofi-wayland power-profiles-daemon ];

  installPhase = ''
    mkdir -p $out/bin
    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu
    wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [ libnotify rofi-wayland ]}

    cp power-profiles.sh $out/bin/power-profiles
    chmod +x $out/bin/power-profiles
    wrapProgram $out/bin/power-profiles --prefix PATH : ${lib.makeBinPath [ libnotify power-profiles-daemon ]}
  '';
}
