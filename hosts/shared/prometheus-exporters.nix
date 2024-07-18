{ config, ... }: {
  services = {
    caddy = {
      virtualHosts."${config.networking.hostName}.labs.adtya.xyz" = {
        extraConfig = ''
          handle /metrics {
            reverse_proxy 127.0.0.1:9100
          }
          handle /systemd-metrics {
            uri replace /systemd-metrics /metrics
            reverse_proxy 127.0.0.1:9558
          }
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    prometheus.exporters = {
      node = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9100;
        enabledCollectors = [ "systemd" ];
      };
      systemd = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9558;
      };

    };
  };
}
