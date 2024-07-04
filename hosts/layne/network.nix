{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  networking = {
    nameservers = [
      "2620:fe::fe#dns.quad9.net"
      "9.9.9.9#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
    ];
    useDHCP = lib.mkDefault false;
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

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [ ];
  };
}
