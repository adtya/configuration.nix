{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix { }; in {
  sops.secrets = {
    "wireguard/rico2/pk" = {
      mode = "400";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51832 ];
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
        ListenPort = 51832;
        PrivateKeyFile = config.sops.secrets."wireguard/rico2/pk".path;
      };
      wireguardPeers = with wireguard-peers; [
        (bifrost // { PersistentKeepalive = 20; })
        rico0
        rico1
        wynne
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
