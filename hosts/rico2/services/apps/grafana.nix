_:
let domainName = "grafana.labs.adtya.xyz"; in {
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9091
        '';
      };
    };
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = domainName;
          http_addr = "127.0.0.1";
          http_port = 9091;
        };
        analytics = {
          enable = false;
        };
        panels = {
          disable_sanitize_html = true;
        };
      };
    };
  };
}
