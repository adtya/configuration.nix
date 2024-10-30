_: {
  networking = {
    useNetworkd = true;
  };
  systemd = {
    network = {
      enable = true;
      wait-online.enable = false;
      networks = {
        "41-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
            Name = "e*";
          };
          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
          };
          dhcpV4Config = {
            UseDomains = true;
          };
          ipv6AcceptRAConfig = {
            UseDomains = true;
          };
          linkConfig = {
            RequiredForOnline = "yes";
          };
          routes = [
            {
              Destination = "165.232.180.97";
              Gateway = "_dhcp4";
              GatewayOnLink = "yes";
            }
          ];
        };
      };
    };
  };
}
