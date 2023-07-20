_: {
  networking = {
    hostName = "Skipper";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  systemd.network = {
    enable = true;
    networks.wifi = {
      enable = true;
      matchConfig = {
        Name = "wlan0";
      };
      networkConfig = {
        DHCP = "yes";
      };
      linkConfig = {
        RequiredForOnline = "yes";
      };
    };
  };
}
