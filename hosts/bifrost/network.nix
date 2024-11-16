{ lib, config, ... }:
let
  wireguard-peers = import ../shared/wireguard-peers.nix;
in
{
  sops.secrets = {
    "wireguard/bifrost/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
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
      "10.10.10.11"
      "10.10.10.12"
    ];
    useDHCP = lib.mkDefault false;
    useNetworkd = true;
    firewall = {
      allowedUDPPorts = [ 51821 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51821;
          privateKeyFile = config.sops.secrets."wireguard/bifrost/pk".path;
          address = [
            "10.10.10.1/24"
          ];
          dns = [ "10.10.10.11" "10.10.10.12" ];
          peers = with wireguard-peers; [
            (rico0 // { endpoint = null; })
            (rico1 // { endpoint = null; })
            (rico2 // { endpoint = null; })
            (wynne // { endpoint = null; })
            (layne // { endpoint = null; })
            skipper
            kowalski
          ];
        };
      };
    };
  };

}
