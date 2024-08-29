_: {
  services = {
    caddy = {
      virtualHosts = {
        "jellyfin.local.adtya.xyz" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
            tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
          '';
        };
        "jellyfin.labs.adtya.xyz" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
            tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
          '';
        };
      };
    };
    jellyfin = {
      enable = true;
      dataDir = "/mnt/data/Jellyfin";
      openFirewall = true;
    };
  };
  systemd.services.jellyfin.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
