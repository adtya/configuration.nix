{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  gnome,
  gnome-icon-theme,
  hicolor-icon-theme,
  flavour ? "",
}:
stdenvNoCC.mkDerivation {
  pname = "newaita-icon-theme";
  version = "unstable-2022-03-18";

  src = fetchFromGitHub {
    owner = "cbrnix";
    repo = "Newaita-reborn";
    rev = "5b19f46a4ca918585038547b27810502a5997401";
    hash = "sha256-nA0l+xH9BlxID0lsXkojKvQRZgkJulSWsRinDre0oW8=";
  };

  nativeBuildInputs = [gtk3];

  propagatedBuildInputs = [
    gnome.adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/Newaita-reborn{,-dark}

    FLAVOUR="${flavour}"
    if [ -n ''$FLAVOUR ]; then
      FLAVOUR="-''$FLAVOUR"
    fi

    cp -ra Newaita-reborn''$FLAVOUR/{actions,apps,categories,devices,emblems,mimetypes,status,panel,places,index.theme} $out/share/icons/Newaita-reborn/
    cp -ra Newaita-reborn''$FLAVOUR-dark/{actions,apps,categories,devices,emblems,mimetypes,status,panel,places,index.theme} $out/share/icons/Newaita-reborn-dark/

    runHook postInstall
  '';

  postFixup = "gtk-update-icon-cache $out/share/icons/Newaita-reborn{,-dark}";

  meta = with lib; {
    description = "Remaster Newaita icon theme";
    homepage = "https://github.com/cbrnix/Newaita-reborn";
    platforms = platforms.linux;
  };
}
