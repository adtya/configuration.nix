{ config, pkgs, ... }: {
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

  xdg.desktopEntries = {
    "umpv" = {
      name = "umpv Media Player";
      exec = "umpv --player-operation-mode=pseudo-gui -- %U";
      noDisplay = true;
    };
  };
}