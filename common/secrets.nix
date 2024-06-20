{ config, ... }: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age = {
      keyFile = "/persist/secrets/sops/age/keys.txt";
      sshKeyPaths = [ "/persist/secrets/ssh/keys/ssh_host_ed25519_key" ];
    };
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
