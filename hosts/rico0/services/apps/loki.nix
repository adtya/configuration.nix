_: {
  services = {
    caddy = {
      virtualHosts."loki.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:3100
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    loki = {
      enable = true;
      dataDir = "/mnt/data/loki";
      configuration = {
        auth_enabled = false;

        server = {
          http_listen_port = 3100;
          log_level = "warn";
        };

        common = {
          ring = {
            instance_addr = "127.0.0.1";
            kvstore = {
              store = "inmemory";
            };
          };
          storage = {
            filesystem = { rules_directory = "/mnt/data/loki/rules"; };
          };
          replication_factor = 1;
          path_prefix = "/mnt/data/loki";
        };

        schema_config = {
          configs = [
            {
              from = "2024-07-01";
              store = "tsdb";
              object_store = "filesystem";
              scheme = "v13";
              index = { prefix = "index_"; period = "24h"; };
            }
          ];
        };

        storage_config = {
          filesystem = {
            directory = "/mnt/data/loki/chunks";
          };
        };

        ruler = {
          alertmanager_url = "https://alertmanager.labs.adtya.xyz";
        };

        frontend = {
          encoding = "protobuf";
        };
      };
    };
  };
  systemd.services.loki.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
