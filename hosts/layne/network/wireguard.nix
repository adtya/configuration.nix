{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix; in {
  sops.secrets = {
    "wireguard/layne/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51834 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51834;
          privateKeyFile = config.sops.secrets."wireguard/layne/pk".path;
          address = [
            "${config.nodeconfig.facts.wireguard-ip}/24"
          ];
          dns = [ "10.10.10.1" ];
          peers = with wireguard-peers; [
            (bifrost // { persistentKeepalive = 20; })
            rico0
            rico1
            rico2
            wynne
          ];
        };
      };
    };
  };

}
