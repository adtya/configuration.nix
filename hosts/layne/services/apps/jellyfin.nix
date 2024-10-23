_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "watch.acomputer.lol";
in
{
  services = {
    caddy = {
      virtualHosts = {
        "jellyfin.local.adtya.xyz" = {
          logFormat = logFormat "jellyfin.local.adtya.xyz";
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
          '';
        };
        "jellyfin.labs.adtya.xyz" = {
          logFormat = logFormat "jellyfin.labs.adtya.xyz";
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
          '';
        };
        "${domainName}" = {
          logFormat = logFormat domainName;
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
          '';
        };
      };
    };
    frp.settings.proxies = [
      {
        name = "http.${domainName}";
        type = "http";
        customDomains = [ domainName ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.${domainName}";
        type = "https";
        customDomains = [ domainName ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
    jellyfin = {
      enable = true;
      user = "mediaserver";
      group = "mediaserver";
      dataDir = "/mnt/data/Jellyfin";
      openFirewall = true;
    };
  };
  systemd.services.jellyfin.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
