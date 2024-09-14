{ lib, config, ... }: {
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
          ${lib.optionalString config.services.prometheus.exporters.postgres.enable ''
          handle /postgres-metrics {
            uri replace /postgres-metrics /metrics
            reverse_proxy ${config.services.prometheus.exporters.postgres.listenAddress}:${toString config.services.prometheus.exporters.postgres.port}
          }
          ''}
        '';
      };
    };
    prometheus.exporters = {
      node = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9100;
        enabledCollectors = [ "systemd" "processes" ];
      };
      systemd = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9558;
      };

    };
  };
}
