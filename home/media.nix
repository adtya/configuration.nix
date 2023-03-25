{pkgs, ...}: {
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
    package = pkgs.mpv.override {youtubeSupport = true;};
    config = {
      hwdec = "auto-safe";
      gpu-context = "wayland";
    };
    defaultProfiles = ["gpu-hq"];
    scripts = with pkgs.mpvScripts; [mpris];
  };
  services = {
    spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {
        withKeyring = true;
        withMpris = true;
      };
      settings = {
        global = {
          use_keyring = true;
          use_mpris = true;
          username_cmd = ''
            ${pkgs.libsecret}/bin/secret-tool search --all service spotifyd 2>&1 | grep 'username' | awk -F'= ' '{print $2}'
          '';
          device_name = "Skipperd";
          device_type = "computer";
          backend = "pulseaudio";
          no_audio_cache = true;
          dbus_type = "session";
        };
      };
    };
  };
}
