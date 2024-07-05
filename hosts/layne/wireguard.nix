{ config, ... }: {
  imports = [ ../shared/wireguard.nix ];

  sops.secrets = {
    "wireguard/layne/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/layne/psk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51834;
    pk-file = config.sops.secrets."wireguard/layne/pk".path;
    psk-file = config.sops.secrets."wireguard/layne/psk".path;
    node-ips = [
      "10.10.10.14/24"
      "fd7c:585c:c4ae::14/64"
    ];
  };
}
