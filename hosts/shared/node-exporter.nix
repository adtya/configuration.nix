{ config, ... }: {
  services = {
    caddy = {
      virtualHosts."${config.networking.hostName}.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy /metrics 127.0.0.1:9100
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    prometheus.exporters.node = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9100;
      enabledCollectors = [ "systemd" ];
    };
  };
}
