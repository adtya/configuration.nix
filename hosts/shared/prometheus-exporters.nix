{ lib, config, ... }:
let
  inherit (import ./caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
in
{
  services = {
    caddy =
      let
        vHost = "${config.networking.hostName}.labs.adtya.xyz";
      in
      {
        virtualHosts."${vHost}" = {
          inherit logFormat;
          extraConfig = ''
            ${tlsAcmeDnsChallenge}
            metrics /caddy-metrics
            handle /metrics {
              reverse_proxy ${config.services.prometheus.exporters.node.listenAddress}:${toString config.services.prometheus.exporters.node.port}
            }
            handle /smartctl-metrics {
              uri replace /smartctl-metrics /metrics
              reverse_proxy ${config.services.prometheus.exporters.smartctl.listenAddress}:${toString config.services.prometheus.exporters.smartctl.port}
            }
            handle /systemd-metrics {
              uri replace /systemd-metrics /metrics
              reverse_proxy ${config.services.prometheus.exporters.systemd.listenAddress}:${toString config.services.prometheus.exporters.systemd.port}
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
      smartctl = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9633;
      };
      systemd = {
        enable = true;
        listenAddress = "127.0.0.1";
        port = 9558;
      };

    };
  };
}
