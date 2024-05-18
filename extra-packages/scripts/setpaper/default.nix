{ lib
, stdenvNoCC
, makeWrapper
, envsubst
, jq
, swww
,
}:
stdenvNoCC.mkDerivation {
  pname = "setpaper";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp setpaper.sh $out/bin/setpaper
    chmod +x $out/bin/setpaper

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/setpaper --prefix PATH : ${lib.makeBinPath [envsubst jq swww]}
  '';
}
