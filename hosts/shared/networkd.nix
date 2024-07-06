_: {
  networking = {
    useNetworkd = true;
  };
  systemd.network = {
    enable = true;
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
}
