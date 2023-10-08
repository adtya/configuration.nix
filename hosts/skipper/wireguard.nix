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
        ips = peers."${config.networking.hostName}".allowedIPs;
        privateKeyFile = "/etc/wireguard/private.key";
        generatePrivateKeyFile = true;
        peers = with peers; [
          Proxy
          Rico2
        ];
      };
    };
  };
}
