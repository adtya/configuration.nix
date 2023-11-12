{ config
, secrets
, ...
}:
let
  inherit (secrets.wireguard_config) peers;
in
{
  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [
          "10.8.1.4/24"
          "fdd9:69ae:9703::4/64"
        ];
        listenPort = 51821;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = with peers; [
          Proxy
        ];
      };
    };
  };
}
