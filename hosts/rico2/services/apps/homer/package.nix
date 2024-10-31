{ lib, stdenvNoCC, fetchzip, configuration ? null, styleSheet ? null }:
stdenvNoCC.mkDerivation rec {
  name = "homer";
  version = "v24.10.2";

  src = fetchzip {
    url = "https://github.com/bastienwirtz/homer/releases/download/v24.10.2/homer.zip";
    sha256 = "sha256-V4E/KLOzfiCMwdQrXzab2VzjuB0TYpocoYhdUVt4g78=";
    stripRoot = false;
  };

  sourceRoot = "${src.name}/";

  configFile =
    if configuration != null
    then (lib.generators.toYAML { } (configuration // { stylesheet = "assets/custom.css"; }))
    else "${src}/assets/config-demo.yml.dist";

  installPhase = ''
    mkdir -p $out/share/web
    cp -r ./* $out/share/web/
    rm $out/share/web/assets/*.dist $out/share/web/*.sample
    cp ${configFile} $out/share/web/assets/config.yml
    ${lib.optionalString (styleSheet != null) "cp ${styleSheet} $out/share/web/assets/custom.css"}
  '';

  meta = {
    homepage = "https://github.com/bastienwirtz/homer";
    description = "A very simple static homepage for your server";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ adtya ];
  };
}
