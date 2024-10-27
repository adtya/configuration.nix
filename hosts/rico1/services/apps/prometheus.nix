_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsDNSChallenge;
  domainName = "prometheus.labs.adtya.xyz";
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        logFormat = logFormat domainName;
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 127.0.0.1:9090
        '';
      };
    };
    prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9090;
      globalConfig = {
        evaluation_interval = "15s";
        scrape_interval = "15s";
      };
      alertmanagers = [
        {
          scheme = "https";
          static_configs = [
            { targets = [ "alertmanager.labs.adtya.xyz" ]; }
          ];
        }
      ];
      scrapeConfigs = [
        {
          job_name = "ntfy";
          scheme = "https";
          metrics_path = "/ntfy-metrics";
          static_configs = [
            { targets = [ "wynne.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "caddy";
          scheme = "https";
          metrics_path = "/caddy-metrics";
          static_configs = [
            { targets = [ "rico0.labs.adtya.xyz" ]; }
            { targets = [ "rico1.labs.adtya.xyz" ]; }
            { targets = [ "rico2.labs.adtya.xyz" ]; }
            { targets = [ "wynne.labs.adtya.xyz" ]; }
            { targets = [ "layne.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "postgres";
          scheme = "https";
          metrics_path = "/postgres-metrics";
          static_configs = [
            { targets = [ "wynne.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "systemd";
          scheme = "https";
          metrics_path = "/systemd-metrics";
          static_configs = [
            { targets = [ "rico0.labs.adtya.xyz" ]; }
            { targets = [ "rico1.labs.adtya.xyz" ]; }
            { targets = [ "rico2.labs.adtya.xyz" ]; }
            { targets = [ "wynne.labs.adtya.xyz" ]; }
            { targets = [ "layne.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "smartctl";
          scheme = "https";
          metrics_path = "/smartctl-metrics";
          static_configs = [
            { targets = [ "rico0.labs.adtya.xyz" ]; }
            { targets = [ "rico1.labs.adtya.xyz" ]; }
            { targets = [ "rico2.labs.adtya.xyz" ]; }
            { targets = [ "wynne.labs.adtya.xyz" ]; }
            { targets = [ "wynne.labs.adtya.xyz" ]; }
            { targets = [ "layne.labs.adtya.xyz" ]; }
          ];
        }
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
