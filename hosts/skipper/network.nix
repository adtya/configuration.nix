{ lib, ... }: {
  networking = {
    firewall = {
      allowedTCPPorts = [
        51413 #Torrent
        53317 #LocalSend
      ];
      allowedUDPPorts = [
        53317 #LocalSend
      ];
    };

    hostName = "Skipper";

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
    extraConfig = ''
      DNS=2620:fe::fe#dns.quad9.net 9.9.9.9#dns.quad9.net 2620:fe::9#dns.quad9.net 149.112.112.112#dns.quad9.net
      FallbackDNS=
      DNSOverTLS=opportunistic
      Domains=~.
    '';
  };
}
