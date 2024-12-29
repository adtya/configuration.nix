{ lib, ... }: {
  systemd = {
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
            Domains = [ "~." ];
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

  services.resolved.enable = true;
  networking = {
    useDHCP = lib.mkDefault false;
    useNetworkd = true;
    nftables.enable = true;
  };
}
