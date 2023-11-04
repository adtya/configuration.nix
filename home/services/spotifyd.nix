{ pkgs
, secrets
, ...
}: {
  services = {
    spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {
        withMpris = true;
      };
      settings = {
        global = {
          inherit (secrets.spotify) username;
          inherit (secrets.spotify) password;
          use_mpris = true;
          device_name = "Skipperd";
          device_type = "computer";
          backend = "pulseaudio";
          no_audio_cache = true;
          dbus_type = "session";
          volume_normalization = true;
          autoplay = true;
          bitrate = 320;
        };
      };
    };
  };
}
