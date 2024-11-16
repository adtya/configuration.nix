{ config, ... }:
let
  wireguard-peers = import ../../shared/wireguard-peers.nix;
in
{
  sops.secrets = {
    "wireguard/skipper/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
    firewall = {
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51822;
          privateKeyFile = config.sops.secrets."wireguard/skipper/pk".path;
          address = [
            "10.10.10.2/24"
          ];
          dns = [ "10.10.10.11" "10.10.10.12" ];
          peers = with wireguard-peers; [
            (bifrost // { allowedIPs = [ "10.10.10.0/24" ]; })
          ];
        };
      };
    };
  };
}
