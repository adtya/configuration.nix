{
  config,
  secrets,
  ...
}: let
  inherit (secrets.wireguard_config) peers Proxy Rico2;
in {
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        inherit (peers."${config.networking.hostName}") ips;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = [
          Proxy
          Rico2
        ];
      };
    };
  };
}
