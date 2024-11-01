{ pkgs, ... }: {
  networking = {
    firewall = {
      allowedTCPPorts = [
        53 #DNS
      ];
      allowedUDPPorts = [
        53 #DNS
      ];
    };
  };
  systemd.services.blocky.unitConfig.After = [ "network-online.target" "wireguard-wg0.service" ];
  services = {
    blocky = {
      enable = true;
      settings = {
        bootstrapDns = [ "tcp+udp:1.1.1.1" ];
        upstreams = {
          init.strategy = "blocking";
          groups = {
            default = [
              # Cloudflare
              "tcp+udp:1.1.1.1"

              # Google
              "tcp+udp:8.8.8.8"
              "tcp+udp:8.8.4.4"

              # Quad9
              "tcp+udp:9.9.9.9"
              "tcp+udp:149.112.112.112"
              "tcp-tls:dns.quad9.net:853"
              "https://dns.quad9.net/dns-query"
            ];
          };
          strategy = "parallel_best";
          timeout = "2s";
          userAgent = "Praise the DNS overlords!";
        };
        connectIPVersion = "v4";
        customDNS = {
          customTTL = "1h";
          filterUnmappedTypes = true;
          mapping = {
            # Local (Home Network)
            "gateway.local.adtya.xyz" = "192.168.0.1";
            "ap1.local.adtya.xyz" = "192.168.1.1";
            "ap2.local.adtya.xyz" = "192.168.1.2";
            "switch.local.adtya.xyz" = "192.168.1.3";
            "jellyfin.local.adtya.xyz" = "192.168.1.14";

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
            "act-cache.labs.adtya.xyz" = "10.10.10.13";
            "blocky.rico1.labs.adtya.xyz" = "10.10.10.11";
            "blocky.rico2.labs.adtya.xyz" = "10.10.10.12";
            "grafana.labs.adtya.xyz" = "10.10.10.12";
            "homepage.labs.adtya.xyz" = "10.10.10.12";
            "jellyfin.labs.adtya.xyz" = "10.10.10.14";
            "loki.labs.adtya.xyz" = "10.10.10.11";
            "prometheus.labs.adtya.xyz" = "10.10.10.11";
            "prowlarr.labs.adtya.xyz" = "10.10.10.14";
            "radarr.labs.adtya.xyz" = "10.10.10.14";
            "readarr.labs.adtya.xyz" = "10.10.10.14";
            "sonarr.labs.adtya.xyz" = "10.10.10.14";
            "transmission.labs.adtya.xyz" = "10.10.10.14";
          };
        };
        conditional = {
          fallbackUpstream = false;
          mapping = {
            "local.adtya.xyz" = "192.168.1.1";
            "1.168.192.in-addr.arpa" = "192.168.1.1";
          };
        };
        blocking = {
          denylists = {
            ads = [
              "https://raw.githubusercontent.com/blocklistproject/Lists/master/ads.txt"
            ];
            pihole = [
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            ];
          };
          allowlists = {
            pihole = [
              (pkgs.writeText "allowlist.txt" ''
                s.youtube.com
              '')
            ];

          };
          clientGroupsBlock = {
            default = [ "ads" "pihole" ];
          };
        };
        clientLookup = {
          upstream = "192.168.1.1";
          singleNameOrder = [ 2 1 ];
        };
        prometheus = {
          enable = true;
          path = "/metrics";
        };
        redis = {
          address = "10.10.10.11:6379";
        };
        log = {
          level = "warn";
          format = "json";
          timestamp = true;
          privacy = true;
        };
      };
    };
  };
}
