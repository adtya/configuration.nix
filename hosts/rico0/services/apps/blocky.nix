{ pkgs, config, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
  systemd.services.blocky = {
    unitConfig = {
      After = [ "network-online.target" ];
      StartLimitIntervalSec = 0;
    };
    serviceConfig.RestartSec = "1s";
  };
  services = {
    caddy.virtualHosts = {
      "dns.labs.adtya.xyz" = {
        listenAddresses = [ config.nodeconfig.facts.tailscale-ip ];
        extraConfig = ''
          import hetzner
          reverse_proxy ${config.services.blocky.settings.ports.http}
        '';
      };
    };

    blocky = {
      enable = true;
      settings = {
        ports = {
          dns = "${config.nodeconfig.facts.local-ip}:53";
          http = "127.0.0.1:8080";
        };
        bootstrapDns = [ "tcp+udp:1.1.1.1" ];
        upstreams = {
          groups = {
            default = [
              "tcp-tls:dns.mullvad.net:853"
              "https://dns.mullvad.net/dns-query"
            ];
          };
          strategy = "parallel_best";
          timeout = "2s";
        };
        connectIPVersion = "v4";
        conditional = {
          fallbackUpstream = false;
          mapping = {
            "local.adtya.xyz" = "192.168.1.1";
            "1.168.192.in-addr.arpa" = "192.168.1.1";
          };
        };
        clientLookup = {
          upstream = "192.168.1.1";
          singleNameOrder = [
            2
            1
          ];
        };
        customDNS = {
          customTTL = "1h";
          filterUnmappedTypes = true;
          mapping = {
            # Local (Home Network)
            "gateway.local.adtya.xyz" = "192.168.0.1";
            "ap1.local.adtya.xyz" = "192.168.1.1";
            "ap2.local.adtya.xyz" = "192.168.1.2";
            "switch.local.adtya.xyz" = "192.168.1.3";
          };
        };
        blocking = {
          loading.strategy = "fast";
          denylists = {
            default = [
              # https://github.com/hagezi/dns-blocklists?tab=readme-ov-file#pro
              "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/pro.txt"
              # StevenBlack default
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            ];
          };
          allowlists = {
            default = [
              (pkgs.writeText "allowlist.txt" ''
                s.youtube.com
              '')
            ];

          };
          clientGroupsBlock = {
            default = [ "default" ];
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
