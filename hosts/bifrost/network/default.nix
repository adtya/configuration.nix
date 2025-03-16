{ lib, ... }:
{
  imports = [ ../../shared/tailscale.nix ];

  systemd = {
    network = {
      enable = true;
      wait-online.enable = false;
      networks = {
        "41-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
          };
          networkConfig = {
            DHCP = "yes";
            IPv4Forwarding = "yes";
            Domains = [ "~." ];
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

  services.resolved.enable = true;
  networking = {
    useDHCP = lib.mkDefault false;
    useNetworkd = true;
  };

}
