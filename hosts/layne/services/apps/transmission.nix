{ pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy = {
      virtualHosts."transmission.labs.adtya.xyz" = {
        logFormat = logFormat "transmission.labs.adtya.xyz";
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
        peer-port = 51515;
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
        idle-seeding-limit = 120;
        ratio-limit-enabled = true;
        ratio-limit = 1;
      };
    };
  };
  systemd.services.transmission.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
