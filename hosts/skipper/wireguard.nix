{secrets, ...}: {
  networking.wireguard = let
    inherit (secrets.wireguard_config) server;
    inherit (secrets.wireguard_config) peers;
  in {
    enable = true;
    interfaces = {
      wg0 = {
        inherit (peers."1") ips;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = [
          server
        ];
      };
    };
  };
}
