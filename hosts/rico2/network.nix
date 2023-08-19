{lib, ...}: {
  networking = {
    hostName = "Rico2";
    useDHCP = lib.mkDefault false;
  };

  services.resolved.enable = true;

  systemd.network = {
    enable = true;
    networks = {
      "40-ether" = {
        enable = true;
        matchConfig = {
          Type = "ether";
        };
        networkConfig = {
          DHCP = "yes";
          IgnoreCarrierLoss = "3s";
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
