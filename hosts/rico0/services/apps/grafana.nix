_: {
  services = {
    caddy = {
      virtualHosts."grafana.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9091
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = "grafana.labs.adtya.xyz";
          http_addr = "127.0.0.1";
          http_port = 9091;
        };
      };
    };
  };
}
