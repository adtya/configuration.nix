{ lib, stdenvNoCC, makeWrapper, libnotify, rofi-wayland, tmux, kitty, imagemagick, swaybg }:

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

    cp chpaper.sh $out/bin/chpaper
    chmod +x $out/bin/chpaper
    wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [ imagemagick swaybg ]}
  '';
}