{ config, ... }: {
  sops.secrets = {
    "wireguard/rico2/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/rico2/psk" = {
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
          "10.10.10.12/24"
          "fd7c:585c:c4ae::12/64"
        ];
        listenPort = 51832;
        privateKeyFile = config.sops.secrets."wireguard/rico2/pk".path;
        peers = [
          {
            name = "Proxy";
            endpoint = "165.232.180.97:51821";
            publicKey = "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=";
            presharedKeyFile = config.sops.secrets."wireguard/rico2/psk".path;
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
