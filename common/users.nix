{
  config,
  pkgs,
  username,
  ...
}:
{
  sops = {
    secrets = {
      "passwd/root" = {
        mode = "400";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
        neededForUsers = true;
      };
      "passwd/adtya" = {
        mode = "400";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
        neededForUsers = true;
      };
    };
  };
  users.mutableUsers = false;
  users.users = {
    root = {
      hashedPasswordFile = config.sops.secrets."passwd/root".path;
    };
    ${username} = {
      uid = 1000;
      hashedPasswordFile = config.sops.secrets."passwd/${username}".path;
      description = "Adithya Nair";
      isNormalUser = true;
      extraGroups = [
        "podman"
        "wheel"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Skipper"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDV12zea8VW/mttaCEat46epaM9VBxk0PZS5kf1l+iAi Gloria"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPodFFNUK16y9bjHVMhr+Ykro3v1FVLbmqKg7mjMv3Wz Kowalski"
      ];
    };
  };
}
