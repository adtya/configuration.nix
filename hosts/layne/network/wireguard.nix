{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix { }; in {
  sops.secrets = {
    "wireguard/layne/pk" = {
      mode = "400";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51834 ];
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
        ListenPort = 51834;
        PrivateKeyFile = config.sops.secrets."wireguard/layne/pk".path;
      };
      wireguardPeers = with wireguard-peers; [
        (bifrost // { PersistentKeepalive = 20; })
        rico0
        rico1
        rico2
        wynne
      ];
    };
    networks."99-Homelab" = {
      matchConfig = {
        Name = "Homelab";
      };
      networkConfig = {
        DNS = "10.10.10.1";
        Domains = [ "labs.adtya.xyz" ];
        Address = [
          "${config.nodeconfig.facts.wireguard-ip}/24"
        ];
      };
    };
  };
}
