{lib, ...}: {
  networking = {
    hostName = "Skipper";
    useDHCP = lib.mkDefault false;
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = false;
        };
        Settings = {
          AutoConnect = "yes";
        };
      };
    };
  };

  services.resolved.enable = true;

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
      };
      "40-wireless" = {
        enable = true;
        matchConfig = {
          Type = "wlan";
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
