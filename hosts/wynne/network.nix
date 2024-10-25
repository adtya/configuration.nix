{ config, ... }: {
  imports = [
    ../shared/network.nix
    ../shared/networkd.nix
    ../shared/wireguard.nix
  ];

  sops.secrets = {
    "wireguard/wynne/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/wynne/psk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51833;
    pk-file = config.sops.secrets."wireguard/wynne/pk".path;
    psk-file = config.sops.secrets."wireguard/wynne/psk".path;
    node-ips = [
      "10.10.10.13/24"
    ];
  };
}
