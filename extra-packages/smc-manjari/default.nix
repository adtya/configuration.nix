{ lib, stdenvNoCC, fetchurl, truetype ? false }:

stdenvNoCC.mkDerivation rec {
  pname = "smc-manjari";
  version = "2.200";

  src = fetchurl {
    url = "https://gitlab.com/api/v4/projects/490109/jobs/artifacts/Version${version}/raw/build/manjari-Version${version}.tar.gz?job=build-tag";
    hash = "sha256-3DyR5RCMPkjjNn3WmwAwE8sernFJiYoqtZ35otuyVWo=";
  };

  unpackPhase = ''
    tar xzf $src
  '';

  installPhase = ''
    runHook preInstall

    install -Dm444 -t $out/share/fonts/opentype otf/*.otf
    ${lib.optionalString truetype "install -Dm444 -t $out/share/fonts/truetype ttf/*.ttf"}

    install -Dm644 -t $out/etc/fonts/conf.d *.conf

    install -Dm644 -t $out/share/doc/${pname}-${version} OFL.txt

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://smc.org.in/fonts/manjari";
    description = "Manjari Malayalam Typeface";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ adtya ];
  };
}
