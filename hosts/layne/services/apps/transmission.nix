{ pkgs, ... }: {
  services = {
    caddy = {
      virtualHosts."transmission.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9091
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
      ];
      settings = {
        peer-port = 51515;
        rpc-bind-address = "127.0.0.1";
        rpc-port = 9091;
        rpc-host-whitelist = "transmission.labs.adtya.xyz";
        watch-dir-enabled = true;
      };
    };
  };
  systemd.services.transmission.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
