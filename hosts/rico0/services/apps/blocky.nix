_: {
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
  services.blocky = {
    enable = true;
    settings = {
      bootstrapDns = [ "tcp+udp:1.1.1.1" ];
      upstreams = {
        init.strategy = "blocking";
        groups = {
          default = [
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
          "frp.local.adtya.xyz" = "10.10.10.10,fd7c:585c:c4ae::10";
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
        };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
      clientLookup = {
        upstream = "192.168.1.1";
        singleNameOrder = [ 2 1 ];
      };
      ports = {
        dns = "192.168.1.10:53,10.10.10.10:53";
        tls = "192.168.1.10:853,10.10.10.10:853";
        https = "192.168.1.10:8443,10.10.10.10:8443";
        http = "192.168.1.10:8080,10.10.10.10:8080";
      };
      log = {
        level = "warn";
        format = "json";
        timestamp = true;
        privacy = true;
      };
    };
  };
}
