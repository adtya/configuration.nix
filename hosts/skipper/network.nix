{lib, ...}: {
  networking = {
    hostName = "Skipper";
    useDHCP = lib.mkDefault false;
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
