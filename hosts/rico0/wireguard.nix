{ config, ... }: {
  sops.secrets = {
    "wireguard/rico0/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/rico0/psk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  networking.firewall.trustedInterfaces = [ "wg0" ];
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        ips = [
          "10.10.10.10/24"
          "fd7c:585c:c4ae::10/64"
        ];
        listenPort = 51830;
        privateKeyFile = config.sops.secrets."wireguard/rico0/pk".path;
        peers = [
          {
            name = "Proxy";
            endpoint = "165.232.180.97:51821";
            publicKey = "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=";
            presharedKeyFile = config.sops.secrets."wireguard/rico0/psk".path;
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
