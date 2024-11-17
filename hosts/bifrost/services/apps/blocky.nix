_:
let domainName = "blocky.labs.adtya.xyz"; in {
  imports = [
    ../../../shared/blocky.nix
  ];
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
    blocky.settings = {
      ports = {
        dns = "10.10.10.1:53";
        http = "127.0.0.1:8080";
      };
      customDNS = {
        mapping = {
          # Labs (Homelab)
          "gateway.labs.adtya.xyz" = "10.10.10.11";
          "ap1.labs.adtya.xyz" = "10.10.10.11";
          "ap2.labs.adtya.xyz" = "10.10.10.11";
          "switch.labs.adtya.xyz" = "10.10.10.11";

          # Hosts
          "proxy.labs.adtya.xyz" = "10.10.10.1";
          "skipper.labs.adtya.xyz" = "10.10.10.2";
          "rico0.labs.adtya.xyz" = "10.10.10.10";
          "rico1.labs.adtya.xyz" = "10.10.10.11";
          "rico2.labs.adtya.xyz" = "10.10.10.12";
          "wynne.labs.adtya.xyz" = "10.10.10.13";
          "layne.labs.adtya.xyz" = "10.10.10.14";

          # Services
          "alertmanager.labs.adtya.xyz" = "10.10.10.12";
          "bazarr.labs.adtya.xyz" = "10.10.10.14";
          "blocky.labs.adtya.xyz" = "10.10.10.1";
          "blocky.local.adtya.xyz" = "10.10.10.10";
          "grafana.labs.adtya.xyz" = "10.10.10.12";
          "homepage.labs.adtya.xyz" = "10.10.10.12";
          "jellyfin.labs.adtya.xyz" = "10.10.10.14";
          "jellyfin.local.adtya.xyz" = "192.168.1.14";
          "lidarr.labs.adtya.xyz" = "10.10.10.14";
          "loki.labs.adtya.xyz" = "10.10.10.11";
          "prometheus.labs.adtya.xyz" = "10.10.10.11";
          "prowlarr.labs.adtya.xyz" = "10.10.10.14";
          "radarr.labs.adtya.xyz" = "10.10.10.14";
          "readarr.labs.adtya.xyz" = "10.10.10.14";
          "sonarr.labs.adtya.xyz" = "10.10.10.14";
          "transmission.labs.adtya.xyz" = "10.10.10.14";
        };
      };
    };
  };
}
