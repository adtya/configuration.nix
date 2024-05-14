{ lib
, stdenvNoCC
, makeWrapper
, curl
, hyprland
, jq
, kitty
, libnotify
, libsecret
, rofi-wayland
, swww
, tmux
, ueberzugpp
, ytfzf
,
}:
stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu

    cp tmux-sessions.sh $out/bin/tmux-sessions
    chmod +x $out/bin/tmux-sessions

    cp chpaper.sh $out/bin/chpaper
    chmod +x $out/bin/chpaper

    cp wallhaven.sh $out/bin/wallhaven
    chmod +x $out/bin/wallhaven

    cp youtube.sh $out/bin/youtube
    chmod +x $out/bin/youtube

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [libnotify rofi-wayland hyprland]}
    wrapProgram $out/bin/tmux-sessions --prefix PATH : ${lib.makeBinPath [tmux kitty rofi-wayland]}
    wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [swww]}
    wrapProgram $out/bin/wallhaven --prefix PATH : ${lib.makeBinPath [jq curl libsecret]}
    wrapProgram $out/bin/youtube --prefix PATH : ${lib.makeBinPath [kitty ytfzf rofi-wayland ueberzugpp]}
  '';
}
