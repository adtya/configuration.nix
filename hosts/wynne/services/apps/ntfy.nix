{ lib, config, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
  domainName = "ntfy.acomputer.lol";
in
{
  services = {
    caddy.virtualHosts = {
      "${domainName}" = {
        inherit logFormat;
        extraConfig = ''
          reverse_proxy ${config.services.ntfy-sh.settings.listen-http}
        '';
      };
      "${config.networking.hostName}.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          handle /ntfy-metrics {
            uri replace /ntfy-metrics /metrics
            reverse_proxy ${config.services.ntfy-sh.settings.metrics-listen-http}
          }
        '';
      };
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
        metrics-listen-http = "127.0.0.1:8081";
        auth-file = "/mnt/data/ntfy-sh/user.db";
        attachment-cache-dir = "/mnt/data/ntfy-sh/attachments";
        cache-file = "/mnt/data/ntfy-sh/cache-file.db";
        enable-login = true;

        auth-default-access = "deny-all";
      };
    };
  };
  systemd.services.ntfy-sh.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
  systemd.services.ntfy-sh.serviceConfig.WorkingDirectory = "/mnt/data/ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.User = "ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.Group = "ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.DynamicUser = lib.mkForce false;
  users.users.ntfy-sh.home = "/mnt/data/ntfy-sh";
  users.users.ntfy-sh.createHome = true;

}
