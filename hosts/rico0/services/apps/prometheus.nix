_: {
  services = {
    caddy = {
      virtualHosts."prometheus.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9090
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      scrapeConfigs = [
        {
          job_name = "node";
          scheme = "https";
          static_configs = [
            { targets = [ "rico0.labs.adtya.xyz" ]; }
            { targets = [ "rico1.labs.adtya.xyz" ]; }
            { targets = [ "rico2.labs.adtya.xyz" ]; }
            { targets = [ "wynne.labs.adtya.xyz" ]; }
            { targets = [ "layne.labs.adtya.xyz" ]; }
          ];
        }
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
