{ config, ... }: {
  imports = [
    ../shared/network.nix
    ../shared/networkd.nix
    ../shared/wireguard.nix
  ];

  sops.secrets = {
    "wireguard/rico2/pk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
    "wireguard/rico2/psk" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  nodeconfig.wireguard = {
    enable = true;
    listen-port = 51832;
    pk-file = config.sops.secrets."wireguard/rico2/pk".path;
    psk-file = config.sops.secrets."wireguard/rico2/psk".path;
    node-ips = [
      "10.10.10.12/24"
      "fd7c:585c:c4ae::12/64"
    ];
  };
}
