{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix { noEndpoints = true; }; in {
  sops.secrets = {
    "wireguard/bifrost/pk" = {
      mode = "400";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51821 ];
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
        ListenPort = 51821;
        PrivateKeyFile = config.sops.secrets."wireguard/bifrost/pk".path;
      };
      wireguardPeers = with wireguard-peers; [
        rico0
        rico1
        rico2
        wynne
        layne
        skipper
        kowalski
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
