{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      youtubeSupport = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        modernx
        thumbfast
      ];
    };
    config = {
      border = "no";
      osc = "no";
      cache = "yes";
      cache-secs = "120";
      hwdec = "auto-safe";
      gpu-context = "wayland";
      vo = "gpu-next";
    };
    defaultProfiles = [ "gpu-hq" ];
    scriptOpts = {
      thumbfast = {
        network = "yes";
        hwdec = "yes";
      };
    };
  };

  xdg.desktopEntries = {
    "umpv" = {
      name = "umpv Media Player";
      exec = "umpv --player-operation-mode=pseudo-gui -- %U";
      noDisplay = true;
    };
  };
}
