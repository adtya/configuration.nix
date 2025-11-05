{ lib, ... }:
{
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
  networking = {
    useDHCP = lib.mkDefault false;
    useNetworkd = true;
    firewall = {
      allowPing = true;
      logRefusedConnections = lib.mkDefault false;
    };
  };
  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
      systemd-networkd.stopIfChanged = false;
      systemd-resolved.stopIfChanged = false;
    };
    network = {
      enable = true;
      wait-online.enable = false;
      networks = {
        "20-virbr" = {
          matchConfig = {
            Name = "virbr*";
            Type = "bridge";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "21-docker" = {
          matchConfig = {
            Name = "docker*";
            Type = "bridge";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "22-veth" = {
          matchConfig = {
            Name = "veth*";
            Type = "ether";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "40-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
          };
          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
          };
          dhcpV4Config = {
            UseDomains = true;
            RouteMetric = 100;
          };
          ipv6AcceptRAConfig = {
            RouteMetric = 100;
          };
          linkConfig = {
            RequiredForOnline = "routable";
          };
        };
      };
    };
  };

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    dnssec = "false";
    extraConfig = ''
      [Resolve]
      DNS=194.242.2.2#dns.mullvad.net
      FallbackDNS=
      Domains=~.
    '';
  };
}
