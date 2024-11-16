{ lib, ... }: {
  imports = [ ./wireguard.nix ];

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [ ];
  };

  networking = {
    nameservers = [
      "10.10.10.11"
      "10.10.10.12"
    ];
    useDHCP = lib.mkDefault false;
    extraHosts = ''
      10.10.10.1 Bifrost
      10.10.10.2 Skipper
      10.10.10.10 Rico0
      10.10.10.11 Rico1
      10.10.10.12 Rico2
      10.10.10.13 Wynne
      10.10.10.14 Layne
    '';

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

    networkmanager = {
      enable = true;
      dhcp = "dhcpcd";
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };

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
}
