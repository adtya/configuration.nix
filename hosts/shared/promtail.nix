{ config, ... }: {
  services = {
    promtail = {
      enable = true;
      configuration = {
        server = {
          http_listen_address = "127.0.0.1";
          http_listen_port = 9080;
          grpc_listen_port = 0;
        };
        clients = [
          {
            url = "https://loki.labs.adtya.xyz/loki/api/v1/push";
          }
        ];
        positions = { filename = "/tmp/promtail-positions.yaml"; };
        scrape_configs = [
          {
            job_name = "caddy";
            static_configs = [
              {
                targets = [ "localhost" ];
                labels = {
                  job = "caddy";
                  "__path__" = "/var/log/caddy/*log";
                  agent = "caddy-promtail";
                };
              }
            ];
            pipeline_stages = [
              {
                json = {
                  expressions = { duration = "duration"; status = "status"; };
                };
              }
              {
                labels = { duration = ""; status = ""; };
              }
            ];
          }
          {
            job_name = "journal";
            journal = {
              json = false;
              max_age = "12h";
              path = "/var/log/journal";
              labels = { job = "systemd-journal"; host = "${config.networking.hostName}"; };
            };
            relabel_configs = [
              {
                source_labels = [ "__journal__systemd_unit" ];
                target_label = "unit";
              }
            ];
          }
        ];
      };
    };
  };
}
