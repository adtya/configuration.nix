{ inputs, pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      serverAliases = [ "www.${domainName}" ];
      inherit logFormat;
      extraConfig = ''
        handle {
          root * ${inputs.adtyaxyz.packages.${pkgs.system}.default}/share/web
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
        customDomains = [ "${domainName}" "www.${domainName}" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.${domainName}";
        type = "https";
        customDomains = [ "${domainName}" "www.${domainName}" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
