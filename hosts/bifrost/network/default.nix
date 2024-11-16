{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  systemd = {
    network = {
      enable = true;
      wait-online.enable = false;
      networks = {
        "41-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
            Name = "e*";
          };
          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
          };
          dhcpV4Config = {
            UseDomains = true;
          };
          linkConfig = {
            RequiredForOnline = "yes";
          };
        };
      };
    };
  };

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [ ];
  };

  networking = {
    nameservers = [
      "1.1.1.1"
      "10.10.10.11"
      "1.0.0.1"
      "10.10.10.12"
    ];
    useDHCP = lib.mkDefault false;
    useNetworkd = true;
  };

}
