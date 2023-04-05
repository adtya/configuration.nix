{ lib, stdenvNoCC, makeWrapperm, libnotify }:
stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu
    wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [ libnotify ]}
  '';
}
