{ lib, stdenvNoCC, fetchurl, truetype ? false }:

stdenvNoCC.mkDerivation rec {
  pname = "smc-nupuram";
  version = "1.000-alpha.16";

  src = fetchurl {
    url = "https://smc.gitlab.io/fonts/Nupuram/fonts/Nupuram.tar.gz";
    hash = "sha256-SmQaOPejcd5pj55BmWT+zIK8dNpmgth/TQSU6OZiCZc=";
  };

  unpackPhase = ''
    tar xzf $src
  '';

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/opentype fonts/Nupuram/otf-variable/*.otf
    ${lib.optionalString truetype "install -Dm444 -t $out/share/fonts/truetype fonts/Nupuram/ttf-variable/*.ttf"}

    install -Dm644 -t $out/etc/fonts/conf.d *.conf

    install -Dm644 -t $out/share/doc/${pname}-${version} OFL.txt

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://smc.org.in/fonts/Nupuram";
    description = "Nupuram Malayalam Typeface";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ adtya ];
  };
}
