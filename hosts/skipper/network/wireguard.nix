{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix { }; in {
  sops.secrets = {
    "wireguard/skipper/pk" = {
      mode = "400";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    firewall = {
      trustedInterfaces = [ "Homelab" ];
    };
  };
  systemd.network = {
    enable = true;
    netdevs."99-Homelab" = {
      netdevConfig = {
        Name = "Homelab";
        Kind = "wireguard";
      };
      wireguardConfig = {
        ListenPort = 51822;
        PrivateKeyFile = config.sops.secrets."wireguard/skipper/pk".path;
      };
      wireguardPeers = with wireguard-peers; [
        (bifrost // { AllowedIPs = [ "10.10.10.0/24" ]; })
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
