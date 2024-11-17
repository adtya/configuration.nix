_:
let domainName = "prometheus.labs.adtya.xyz"; in {
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
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
          static_configs = [
            { targets = [ "10.10.10.13:8081" ]; }
          ];
        }
        {
          job_name = "caddy";
          static_configs = [
            { targets = [ "10.10.10.1:2019" ]; }
            { targets = [ "10.10.10.10:2019" ]; }
            { targets = [ "10.10.10.11:2019" ]; }
            { targets = [ "10.10.10.12:2019" ]; }
            { targets = [ "10.10.10.13:2019" ]; }
            { targets = [ "10.10.10.14:2019" ]; }
          ];
        }
        {
          job_name = "postgres";
          static_configs = [
            { targets = [ "10.10.10.13:9187" ]; }
          ];
        }
        {
          job_name = "systemd";
          static_configs = [
            { targets = [ "10.10.10.1:9558" ]; }
            { targets = [ "10.10.10.10:9558" ]; }
            { targets = [ "10.10.10.11:9558" ]; }
            { targets = [ "10.10.10.12:9558" ]; }
            { targets = [ "10.10.10.13:9558" ]; }
            { targets = [ "10.10.10.14:9558" ]; }
          ];
        }
        {
          job_name = "smartctl";
          static_configs = [
            { targets = [ "10.10.10.10:9633" ]; }
            { targets = [ "10.10.10.11:9633" ]; }
            { targets = [ "10.10.10.12:9633" ]; }
            { targets = [ "10.10.10.13:9633" ]; }
            { targets = [ "10.10.10.14:9633" ]; }
          ];
        }
        {
          job_name = "node";
          static_configs = [
            { targets = [ "10.10.10.1:9100" ]; }
            { targets = [ "10.10.10.10:9100" ]; }
            { targets = [ "10.10.10.11:9100" ]; }
            { targets = [ "10.10.10.12:9100" ]; }
            { targets = [ "10.10.10.13:9100" ]; }
            { targets = [ "10.10.10.14:9100" ]; }
          ];
        }
        {
          job_name = "blocky";
          scheme = "https";
          static_configs = [
            { targets = [ "blocky.rico1.labs.adtya.xyz" ]; }
            { targets = [ "blocky.rico2.labs.adtya.xyz" ]; }
          ];
        }
        {
          job_name = "redis";
          static_configs = [
            { targets = [ "10.10.10.11:9121" ]; }
          ];
        }
      ];
    };
  };
}
