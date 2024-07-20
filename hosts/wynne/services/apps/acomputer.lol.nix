_: {
  services = {
    caddy.virtualHosts."acomputer.lol" = {
      extraConfig = ''
        handle /.well-known/matrix/server {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          respond `{"m.server": "matrix.acomputer.lol:443"}`
        }

        handle /.well-known/matrix/client {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          respond `{"m.homeserver": {"base_url": "https://matrix.acomputer.lol:443"}}`
        }
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.acomputer.lol";
        type = "http";
        customDomains = [ "acomputer.lol" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.acomputer.lol";
        type = "https";
        customDomains = [ "acomputer.lol" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
