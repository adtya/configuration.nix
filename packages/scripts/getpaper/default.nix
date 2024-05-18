{ lib
, stdenvNoCC
, makeWrapper
, curl
, envsubst
, jq
, libsecret
,
}:
stdenvNoCC.mkDerivation {
  pname = "getpaper";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp getpaper.sh $out/bin/getpaper
    chmod +x $out/bin/getpaper

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/getpaper --prefix PATH : ${lib.makeBinPath [envsubst jq curl libsecret]}
  '';
}
