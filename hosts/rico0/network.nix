{ config, ... }: {
  imports = [
    ../shared/network.nix
    ../shared/networkd.nix
    ../shared/wireguard.nix
  ];

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

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51830;
    pk-file = config.sops.secrets."wireguard/rico0/pk".path;
    psk-file = config.sops.secrets."wireguard/rico0/psk".path;
    node-ips = [
      "10.10.10.10/24"
    ];
  };
}
