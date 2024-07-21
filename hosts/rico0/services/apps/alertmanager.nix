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
    };
  };
}
