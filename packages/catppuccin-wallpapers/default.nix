{ lib
, stdenvNoCC
, fetchFromGitHub
,
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-wallpapers";
  version = "latest";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "wallpapers";
    rev = "460356d349d3af42fcc7874df5ac95f2040710ad";
    hash = "sha256-M5OmZXcH1pBFxjtRX9BcPaf7zwuZVAR+j/rG7uyRU3I=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers/catppuccin
    find . -type f -regextype egrep -regex ".*\.(jpe?g|png)$" -exec cp {} $out/share/wallpapers/catppuccin/ \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Wallpapers to match your Catppuccin setups!";
    homepage = "https://github.com/catppuccin/wallpapers";
    license = licenses.mit;
  };
}
