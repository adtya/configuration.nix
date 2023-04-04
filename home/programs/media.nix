{ pkgs, ... }: {
  xdg.desktopEntries."mpv".name = "mpv Media Player";
  xdg.desktopEntries."mpv".exec = "mpv --player-operation-mode=pseudo-gui -- %U";
  xdg.desktopEntries."mpv".noDisplay = true;

  xdg.desktopEntries."umpv".name = "umpv Media Player";
  xdg.desktopEntries."umpv".exec = "umpv --player-operation-mode=pseudo-gui -- %U";
  xdg.desktopEntries."umpv".noDisplay = true;

  home.packages = with pkgs; [
    celluloid
    spotify-tui
    playerctl
  ];
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override { youtubeSupport = true; };
    config = {
      hwdec = "auto-safe";
      gpu-context = "wayland";
    };
    defaultProfiles = [ "gpu-hq" ];
    scripts = with pkgs.mpvScripts; [ mpris ];
  };
}
