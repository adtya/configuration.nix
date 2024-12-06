{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix { }; in {
  sops.secrets = {
    "wireguard/wynne/pk" = {
      mode = "400";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51833 ];
      trustedInterfaces = [ "Homelab" ];
    };
  };
  systemd.network = {
    netdevs."99-Homelab" = {
      netdevConfig = {
        Name = "Homelab";
        Kind = "wireguard";
      };
      wireguardConfig = {
        ListenPort = 51833;
        PrivateKeyFile = config.sops.secrets."wireguard/wynne/pk".path;
      };
      wireguardPeers = with wireguard-peers; [
        (bifrost // { PersistentKeepalive = 20; })
        rico0
        rico1
        rico2
        layne
      ];
    };
    networks."99-Homelab" = {
      matchConfig = {
        Name = "Homelab";
      };
      networkConfig = {
        DNS = "10.10.10.1";
        Address = [
          "${config.nodeconfig.facts.wireguard-ip}/24"
        ];
      };
    };
  };
}
