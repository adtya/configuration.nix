_: {
  services = {
    caddy = {
      virtualHosts."prometheus.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9090
          tls /persist/secrets/caddy/certs/prometheus.crt /persist/secrets/caddy/certs/prometheus.key
        '';
      };
    };
    prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      scrapeConfigs = [
        {
          job_name = "frp";
          scheme = "https";
          static_configs = [
            { targets = [ "frp.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "blocky";
          scheme = "https";
          static_configs = [
            { targets = [ "blocky.labs.adtya.xyz" ]; }
          ];
        }
      ];
    };
  };
}
