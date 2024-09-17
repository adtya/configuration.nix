_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "ntfy.acomputer.lol";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      logFormat = logFormat domainName;
      extraConfig = ''
        reverse_proxy 127.0.0.1:8080
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
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = "https://${domainName}";
        listen-http = "127.0.0.1:8080";
      };
    };
  };
}
