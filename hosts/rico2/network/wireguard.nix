{ config, ...}:
let
  wireguard-peers = import ../shared/wireguard-peers.nix;
in
{
  sops.secrets = {
    "wireguard/rico2/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51832 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51832;
          privateKeyFile = config.sops.secrets."wireguard/rico2/pk".path;
          address = [
            "10.10.10.12/24"
          ];
          dns = [ "10.10.10.11" "10.10.10.12" ];
          peers = with wireguard-peers; [
            (bifrost // { persistentKeepalive = 20; })
            rico0
            rico1
            wynne
            layne
          ];
        };
      };
    };
  };
}
