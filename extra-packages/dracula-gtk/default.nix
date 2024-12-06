{ lib
, stdenvNoCC
, fetchFromGitHub
, gtk-engine-murrine
,
}:
stdenvNoCC.mkDerivation {
  pname = "dracula-gtk";
  version = "unstable-2023-10-14";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "3478e48925f33af411393adaa4043193f03a4e9a";
    hash = "sha256-/7/zJXk1LLZKWOpYbrFWBfhFcyddU1y0IwT+RXyyP1M=";
  };

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
