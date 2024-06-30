{ config, ... }: {
  sops.secrets."wireguard/psk/rico1" = {
    mode = "400";
    owner = config.users.users.root.name;
    group = config.users.users.root.group;
  };

  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [
          "10.10.10.11/24"
          "fd7c:585c:c4ae::11/64"
        ];
        listenPort = 51822;
        privateKeyFile = "/persist/secrets/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = [
          {
            name = "Proxy";
            endpoint = "165.232.180.97:51821";
            publicKey = "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=";
            presharedKeyFile = config.sops.secrets."wireguard/psk/rico1".path;
            persistentKeepalive = 20;
            allowedIPs = [
              "10.10.10.0/24"
              "fd7c:585c:c4ae::0/64"
            ];
          }
        ];
      };
    };
  };
}
