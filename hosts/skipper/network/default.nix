{ lib, ... }: {
  imports = [
    ./wireguard.nix
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        41414 #Torrent
        53317 #LocalSend
      ];
      allowedUDPPorts = [
        6771 #Torrent
        41414 #Torrent
        53317 #LocalSend
      ];
    };

    nameservers = [
      "2620:fe::fe#dns.quad9.net"
      "9.9.9.9#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
    ];

    networkmanager = {
      enable = true;
      dhcp = "dhcpcd";
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };

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

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [ ];
  };
}
