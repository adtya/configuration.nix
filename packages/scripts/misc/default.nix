{ lib
, stdenvNoCC
, makeWrapper
, hyprland
, kitty
, libnotify
, rofi-wayland
, tmux
,
}:
stdenvNoCC.mkDerivation {
  pname = "misc-scripts";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu

    cp tmux-sessions.sh $out/bin/tmux-sessions
    chmod +x $out/bin/tmux-sessions

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [libnotify rofi-wayland hyprland]}
    wrapProgram $out/bin/tmux-sessions --prefix PATH : ${lib.makeBinPath [tmux kitty rofi-wayland]}
  '';
}
