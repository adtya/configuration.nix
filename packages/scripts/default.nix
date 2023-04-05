{ lib, stdenvNoCC, makeWrapper, libnotify, rofi-wayland, tmux, kitty }:

stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "0.1";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ libnotify rofi-wayland tmux kitty ];

  installPhase = ''
    mkdir -p $out/bin
    cp power-menu.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu
    wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [ libnotify rofi-wayland ]}

    cp tmux-sessions.sh $out/bin/tmux-sessions
    chmod +x $out/bin/tmux-sessions
    wrapProgram $out/bin/tmux-sessions --prefix PATH : ${lib.makeBinPath [ tmux kitty rofi-wayland ]}
  '';
}
