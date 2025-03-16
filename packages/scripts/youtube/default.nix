{ lib
, stdenvNoCC
, makeWrapper
, mpv
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
  buildInputs = [ kitty mpv rofi-wayland ueberzugpp ytfzf ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp youtube.sh $out/bin/youtube
    chmod +x $out/bin/youtube

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/youtube --prefix PATH : ${lib.makeBinPath [kitty mpv rofi-wayland ueberzugpp ytfzf]}
  '';

  meta.mainProgram = "youtube";
}
