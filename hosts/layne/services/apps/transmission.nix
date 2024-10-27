{ pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
in
{
  services = {
    caddy = {
      virtualHosts."transmission.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 127.0.0.1:9091
        '';
      };
    };
    transmission = {
      user = "mediaserver";
      group = "mediaserver";
      enable = true;
      package = pkgs.transmission_4;
      downloadDirPermissions = "775";
      home = "/mnt/data/Torrents";
      webHome = pkgs.flood-for-transmission;
      openPeerPorts = true;
      extraFlags = [
        "--encryption-required"
        "--no-portmap"
        "--dht"
        "--lpd"
      ];
      settings = {
        peer-port = 64450;
        rpc-bind-address = "127.0.0.1";
        rpc-port = 9091;
        rpc-host-whitelist = "transmission.labs.adtya.xyz";
        watch-dir-enabled = true;
        preallocation = 2;
        alt-speed-time-enabled = true;
        alt-speed-time-begin = 360; # 6AM
        alt-speed-time-end = 1320; # 10PM
        alt-speed-time-day = 127; # 1111111 (Everyday)
        alt-speed-down = 10240;
        alt-speed-up = 8192;
        speed-limit-down-enabled = true;
        speed-limit-down = 20480;
        speed-limit-up-enabled = true;
        speed-limit-up = 16384;
        idle-seeding-limit-enabled = true;
        idle-seeding-limit = 360;
        ratio-limit-enabled = true;
        ratio-limit = 2;
        download-queue-enabled = true;
        download-queue-size = 5;
        queue-stalled-enabled = true;
        queue-stalled-minutes = 30;
        seed-queue-enabled = true;
        seed-queue-size = 15;
        peer-limit-global = 400;
        peer-limit-per-torrent = 20;
      };
    };
  };
  systemd.services.transmission.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
  systemd.timers.transmission-port-mapping = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:*:00/30";
      Unit = "transmission-port-mapping.service";
    };
  };

  systemd.services.transmission-port-mapping = {
    script = ''
      set -eu
      ${pkgs.libnatpmp}/bin/natpmpc -g 10.2.0.1 -a 1 0 tcp 60
      ${pkgs.libnatpmp}/bin/natpmpc -g 10.2.0.1 -a 1 0 udp 60
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
