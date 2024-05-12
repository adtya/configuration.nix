{ secrets, ... }:
let
  wireguard_server = secrets.wireguard_server // {
    persistentKeepalive = 20;
    allowedIPs = [
      "10.10.10.0/24"
      "fd7c:585c:c4ae::0/64"
    ];
  };
in
{
  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [
          "10.10.10.2/24"
          "fd7c:585c:c4ae::2/64"
        ];
        listenPort = 51822;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = [
          wireguard_server
        ];
      };
    };
  };
}
