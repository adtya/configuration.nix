{ inputs, pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "wiki.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        handle {
          root * ${inputs.wiki.packages.${pkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
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
