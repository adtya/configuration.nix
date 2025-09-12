{ config, primary-user, ... }:
{
  sops = {
    secrets = {
      "passwd/root" = {
        mode = "400";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
        neededForUsers = true;
      };
      "passwd/${primary-user.name}" = {
        mode = "400";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
        neededForUsers = true;
      };
    };
  };
  nodeconfig.users = {
    root-password-hash-file = config.sops.secrets."passwd/root".path;
    primary = {
      inherit (primary-user) name long-name;
      password-hash-file = config.sops.secrets."passwd/${primary-user.name}".path;
      allowed-ssh-keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Skipper"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPodFFNUK16y9bjHVMhr+Ykro3v1FVLbmqKg7mjMv3Wz Kowalski"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxjkWuf73U2AfJajJfNl6h4/R5ko+WCI1nl9XH/9AJP Thor"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Gloria"
      ];
    };
  };
}
