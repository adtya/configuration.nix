{ config, ... }:
let wireguard-peers = import ../../shared/wireguard-peers.nix; in {
  sops.secrets = {
    "wireguard/bifrost/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
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
            "${config.nodeconfig.facts.wireguard-ip}/24"
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
