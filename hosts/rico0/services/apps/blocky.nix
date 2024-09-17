_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "blocky.labs.adtya.xyz";
in
{
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
    caddy = {
      virtualHosts."${domainName}" = {
        logFormat = logFormat domainName;
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
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
          rewrite = {
            "jellyfin.local.adtya.xyz" = "layne.local.adtya.xyz";

            "gateway.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "ap1.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "ap2.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "switch.labs.adtya.xyz" = "rico0.labs.adtya.xyz";

            "alertmanager.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "blocky.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "frp.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "grafana.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "loki.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "prometheus.labs.adtya.xyz" = "rico0.labs.adtya.xyz";
            "transmission.labs.adtya.xyz" = "layne.labs.adtya.xyz";
            "jellyfin.labs.adtya.xyz" = "layne.labs.adtya.xyz";
          };
          mapping = {
            "gateway.local.adtya.xyz" = "192.168.0.1";
            "ap1.local.adtya.xyz" = "192.168.1.1";
            "ap2.local.adtya.xyz" = "192.168.1.2";
            "switch.local.adtya.xyz" = "192.168.1.3";
            "rico0.local.adtya.xyz" = "192.168.1.10";
            "rico1.local.adtya.xyz" = "192.168.1.11";
            "rico2.local.adtya.xyz" = "192.168.1.12";
            "wynne.local.adtya.xyz" = "192.168.1.13";
            "layne.local.adtya.xyz" = "192.168.1.14";

            "proxy.labs.adtya.xyz" = "10.10.10.1,fd7c:585c:c4ae::1";
            "skipper.labs.adtya.xyz" = "10.10.10.2,fd7c:585c:c4ae::2";
            "rico0.labs.adtya.xyz" = "10.10.10.10,fd7c:585c:c4ae::10";
            "rico1.labs.adtya.xyz" = "10.10.10.11,fd7c:585c:c4ae::11";
            "rico2.labs.adtya.xyz" = "10.10.10.12,fd7c:585c:c4ae::12";
            "wynne.labs.adtya.xyz" = "10.10.10.13,fd7c:585c:c4ae::13";
            "layne.labs.adtya.xyz" = "10.10.10.14,fd7c:585c:c4ae::14";

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
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            ];
          };
          clientGroupsBlock = {
            default = [ "ads" ];
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
        ports = {
          dns = "192.168.1.10:53,10.10.10.10:53";
          tls = "192.168.1.10:853,10.10.10.10:853";
          http = "127.0.0.1:8080";
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
