{ config, ... }: {
  sops.secrets = {
    "wireguard/skipper/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/skipper/psk" = {
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
          "10.10.10.2/24"
          "fd7c:585c:c4ae::2/64"
        ];
        listenPort = 51822;
        privateKeyFile = config.sops.secrets."wireguard/skipper/pk".path;
        peers = [
          {
            name = "Proxy";
            endpoint = "165.232.180.97:51821";
            publicKey = "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=";
            presharedKeyFile = config.sops.secrets."wireguard/skipper/psk".path;
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