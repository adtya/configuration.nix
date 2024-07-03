{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  networking = {
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
    };

    useDHCP = lib.mkDefault false;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [ ];
  };
}
