{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  gnome-themes-extra,
  gtk-engine-murrine,
}:
stdenvNoCC.mkDerivation {
  pname = "dracula-gtk";
  version = "4.0";

  src = fetchFromGitHub {
    owner = "dracula";
    repo = "gtk";
    rev = "42dc8ed0504a58426b96794237981debc57b04fc";
    hash = "sha256-p9zu40o7gP08juBiDV3OzwGV6Qjgg/I0GDzV9qOlEgk=";
  };

  nativeBuildInputs = [gtk3];

  buildInputs = [
    gnome-themes-extra
  ];

  propagatedUserEnvPkgs = [gtk-engine-murrine];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/Dracula
    cp -ra assets cinnamon gnome-shell gtk-2.0 gtk-3.0 gtk-3.20 gtk-4.0 metacity-1 unity xfwm4 index.theme $out/share/themes/Dracula/

    runHook postInstall
  '';
  meta = with lib; {
    description = "Dracula GTK theme";
    homepage = "https://draculatheme.com/gtk";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
