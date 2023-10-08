{
  config,
  secrets,
  ...
}: let
  inherit (secrets.wireguard_config) peers;
in {
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg0 = {
        inherit (peers."${config.networking.hostName}") ips;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = with peers; [
          Proxy
          Skipper
        ];
      };
    };
  };
}
