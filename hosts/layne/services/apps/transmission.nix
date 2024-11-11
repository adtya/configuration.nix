{ pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy = {
      virtualHosts."transmission.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
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
        peer-port = 42069;
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
}
