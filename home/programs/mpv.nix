{ config, pkgs, ... }: {
  home.packages = with pkgs; [ celluloid ];
  dconf.settings = {
    "io/github/celluloid-player/celluloid" = {
      mpv-config-file = "file://${config.home.homeDirectory}/${config.xdg.configFile."mpv/mpv.conf".target}";
    };
  };
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
    "mpv" = {
      name = "mpv Media Player";
      exec = "mpv --player-operation-mode=pseudo-gui -- %U";
      noDisplay = true;
    };

    "umpv" = {
      name = "umpv Media Player";
      exec = "umpv --player-operation-mode=pseudo-gui -- %U";
      noDisplay = true;
    };
  };
}
