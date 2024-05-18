{ lib
, stdenvNoCC
, makeWrapper
, kitty
, rofi-wayland
, ueberzugpp
, ytfzf
,
}:
stdenvNoCC.mkDerivation {
  pname = "youtube";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp youtube.sh $out/bin/youtube
    chmod +x $out/bin/youtube

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/youtube --prefix PATH : ${lib.makeBinPath [kitty ytfzf rofi-wayland ueberzugpp]}
  '';
}
