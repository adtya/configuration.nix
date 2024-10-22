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
          };
          networkConfig = {
            DHCP = "yes";
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
        };
      };
    };
  };
}
