_: {
  services = {
    caddy = {
      virtualHosts."alertmanager.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:3100
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    prometheus.alertmanager = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9093;
      webExternalUrl = "https://alertmanager.labs.adtya.xyz/";
      configuration = {
        route = {
          group_by = [ "alertname" ];
          group_wait = "30s";
          group_interval = "5m";
          repeat_interval = "1h";
          receiver = "web.hook";
        };
        receivers = [
          {
            name = "web.hook";
            webhook_configs = [
              { url = "http://127.0.0.1:5001/"; }
            ];
          }
        ];
        inhibit_rules = [
          {
            source_match =
              { severity = "critical"; };
            target_match =
              { severity = "warning"; };
            equal = [ "alertname" "dev" "instance" ];
          }
        ];
      };
    };
  };
}
