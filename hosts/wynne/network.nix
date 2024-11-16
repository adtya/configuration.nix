{ lib, config, ... }:
let
  wireguard-peers = import ../shared/wireguard-peers.nix;
in
{
  sops.secrets = {
    "wireguard/wynne/pk" = {
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
    useDHCP = lib.mkDefault false;
    nameservers = [
      "10.10.10.11"
      "10.10.10.12"
    ];
    useNetworkd = true;
    firewall = {
      allowedUDPPorts = [ 51833 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51833;
          privateKeyFile = config.sops.secrets."wireguard/wynne/pk".path;
          address = [
            "10.10.10.13/24"
          ];
          dns = [ "10.10.10.11" "10.10.10.12" ];
          peers = with wireguard-peers; [
            (bifrost // { persistentKeepalive = 20; })
            rico0
            rico1
            rico2
            layne
          ];
        };
      };
    };
  };
}
