_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "acomputer.lol";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        handle /.well-known/matrix/server {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          respond `{"m.server": "matrix.${domainName}:443"}`
        }

        handle /.well-known/matrix/client {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          #respond `{"m.homeserver": {"base_url": "https://matrix.${domainName}:443"}, "org.matrix.msc3575.proxy": {"url": "https://matrix.${domainName}"}}`
          respond `{"m.homeserver": {"base_url": "https://matrix.${domainName}:443"}}`
        }
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.${domainName}";
        type = "http";
        customDomains = [ "${domainName}" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.${domainName}";
        type = "https";
        customDomains = [ "${domainName}" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
