{ config, pkgs, ... }: {
  users.mutableUsers = false;
  users.users = {
    root = {
      hashedPasswordFile = config.sops.secrets."passwd/root".path;
    };
    adtya = {
      uid = 1000;
      hashedPasswordFile = config.sops.secrets."passwd/adtya".path;
      description = "Adithya Nair";
      isNormalUser = true;
      extraGroups = [ "docker" "libvirtd" "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Skipper"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPodFFNUK16y9bjHVMhr+Ykro3v1FVLbmqKg7mjMv3Wz Kowalski"
      ];
    };
  };
}
