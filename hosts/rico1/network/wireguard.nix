{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix; in {
  sops.secrets = {
    "wireguard/rico1/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51831 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51831;
          privateKeyFile = config.sops.secrets."wireguard/rico1/pk".path;
          address = [
            "${config.nodeconfig.facts.wireguard-ip}/24"
          ];
          dns = [ "10.10.10.1" ];
          peers = with wireguard-peers; [
            (bifrost // { persistentKeepalive = 20; })
            rico0
            rico2
            wynne
            layne
          ];
        };
      };
    };
  };
}
