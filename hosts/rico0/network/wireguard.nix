{config, ...}:
let
  wireguard-peers = import ../../shared/wireguard-peers.nix;
in
{
  sops.secrets = {
    "wireguard/rico0/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  networking = {
    firewall = {
      allowedUDPPorts = [ 51830 ];
      trustedInterfaces = [ "Homelab" ];
    };
    wg-quick = {
      interfaces = {
        Homelab = {
          listenPort = 51830;
          privateKeyFile = config.sops.secrets."wireguard/rico0/pk".path;
          address = [
            "10.10.10.10/24"
          ];
          dns = [ "10.10.10.11" "10.10.10.12" ];
          peers = with wireguard-peers; [
            (bifrost // { persistentKeepalive = 20; })
            rico1
            rico2
            wynne
            layne
          ];
        };
      };
    };
  };
}
