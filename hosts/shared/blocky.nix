{ pkgs, ... }: {
  systemd.services.blocky.unitConfig.After = [ "network-online.target" ];
  services = {
    blocky = {
      enable = true;
      settings = {
        bootstrapDns = [ "tcp+udp:1.1.1.1" ];
        upstreams = {
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
          mapping = { };
        };
        blocking = {
          loading.strategy = "fast";
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
        prometheus = {
          enable = true;
          path = "/metrics";
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
