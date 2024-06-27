{ config, ... }: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    secrets = {
      "passwd/root" = {
        mode = "400";
        owner = config.users.users.root.name;
        group = config.users.users.root.group;
        neededForUsers = true;
      };
      "passwd/adtya" = {
        mode = "400";
        owner = config.users.users.root.name;
        group = config.users.users.root.group;
        neededForUsers = true;
      };
      "wireguard/psk" = {
        mode = "400";
        owner = config.users.users.root.name;
        group = config.users.users.root.group;
      };
    };
  };
}
