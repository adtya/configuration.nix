{ pkgs, ... }: {
  services = {
    caddy = {
      virtualHosts."transmission.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 10.10.10.14:9091
          tls /persist/secrets/caddy/certs/transmission.crt /persist/secrets/caddy/certs/transmission.key
        '';
      };
    };
    transmission = {
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
        "--allowed"
        "127.0.0.1,10.10.10.*"
      ];
      settings = {
        peer-port = 51515;
        rpc-bind-address = "10.10.10.14";
        rpc-port = 9091;
        watch-dir-enabled = true;
      };
    };
  };
  systemd.services.transmission.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
