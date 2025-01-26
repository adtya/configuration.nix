{ pkgs, username, ... }: {
  users.users.${username} = {
    uid = 501;
    gid = 20;
    description = "Adithya Nair";
    home = "/Users/${username}";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Skipper"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDV12zea8VW/mttaCEat46epaM9VBxk0PZS5kf1l+iAi Gloria"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPodFFNUK16y9bjHVMhr+Ykro3v1FVLbmqKg7mjMv3Wz Kowalski"
    ];
  };
}
