{ config, ... }: {
  imports = [ ../../shared/wireguard.nix ];

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

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51822;
    pk-file = config.sops.secrets."wireguard/skipper/pk".path;
    psk-file = config.sops.secrets."wireguard/skipper/psk".path;
    node-ips = [
      "10.10.10.2/24"
    ];
  };
}
