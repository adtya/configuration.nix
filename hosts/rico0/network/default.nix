{ lib, ... }: {
  imports = [ ./wireguard.nix ];
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
    useDHCP = lib.mkDefault false;
    nameservers = [
      "10.10.10.11"
      "10.10.10.12"
    ];
    useNetworkd = true;
  };
}
