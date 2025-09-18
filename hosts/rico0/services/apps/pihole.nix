{ config, ... }:
{
  services = {
    caddy.virtualHosts = {
      "pihole.labs.adtya.xyz" = {
        listenAddresses = [ config.nodeconfig.facts.tailscale-ip ];
        extraConfig = ''
          import hetzner
          reverse_proxy 127.0.0.1:8053
        '';
      };
    };
    pihole-ftl = {
      enable = true;
      queryLogDeleter.enable = true;
      openFirewallDNS = true;
      lists = [
        # https://github.com/hagezi/dns-blocklists?tab=readme-ov-file#pro
        { url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/pro.txt"; }

        # StevenBlack default
        { url = "https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/hosts"; }
      ];
      settings = {
        dns = {
          interface = "eth0";
          listeningMode = "BIND";
          upstreams = [
            "8.8.8.8"
            "8.8.4.4"
            "1.1.1.1"
            "1.0.0.1"
          ];
          revServers = [ "true,192.168.1.1/24,192.168.1.1,local.adtya.xyz" ];
          piholePTR = "HOSTNAMEFQDN";
          domain = "local.adtya.xyz";
          ignoreLocalhost = true;
          domainNeeded = true;
        };
        ntp = {
          ipv4.active = false;
          ipv6.active = false;
          sync.active = false;
        };
        webserver.interface.theme = "lcars";
      };
    };
    pihole-web = {
      enable = true;
      hostName = "pihole.labs.adtya.xyz";
      ports = [ "127.0.0.1:8053" ];
    };
  };
}
