{ config, ... }: {
  imports = [
    ../shared/network.nix
    ../shared/networkd.nix
    ../shared/wireguard.nix
  ];

  sops.secrets = {
    "wireguard/rico1/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/rico1/psk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51831;
    pk-file = config.sops.secrets."wireguard/rico1/pk".path;
    psk-file = config.sops.secrets."wireguard/rico1/psk".path;
    node-ips = [
      "10.10.10.11/24"
      "fd7c:585c:c4ae::11/64"
    ];
  };
}
