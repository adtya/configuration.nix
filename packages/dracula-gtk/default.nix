{ lib
, stdenvNoCC
, fetchFromGitHub
, gtk3
, gnome-themes-extra
, gtk-engine-murrine
,
}:
stdenvNoCC.mkDerivation {
  pname = "dracula-gtk";
  version = "unstable-2023-10-14";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "a0b0ab451447d374600a74519abaa0588f2fa536";
    hash = "sha256-0Ndk9Mh58KU2eoG1Z/CzZPiLNxy2bdloq9p4gzMDu2M=";
  };
  nativeBuildInputs = [ gtk3 ];

  buildInputs = [
    gnome-themes-extra
  ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/Dracula
    cp -ra assets cinnamon gnome-shell gtk-2.0 gtk-3.0 gtk-3.20 gtk-4.0 metacity-1 unity xfwm4 index.theme $out/share/themes/Dracula/

    runHook postInstall
  '';
  meta = with lib; {
    description = "Dracula GTK theme";
    downloadPage = "https://github.com/dracula/gtk";
    homepage = "https://draculatheme.com/gtk";
    license = licenses.gpl3;
    maintainers = with maintainers; [ adtya ];
    platforms = platforms.linux;
  };
}
