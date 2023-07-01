{
  pkgs,
  secrets,
  ...
}: let
  user = secrets.users;
in {
  users.mutableUsers = false;
  users.users = {
    root.hashedPassword = user.root.hashedPassword;
    "${user.primary.userName}" = {
      uid = 1000;
      hashedPassword = user.primary.hashedPassword;
      description = user.primary.realName;
      isNormalUser = true;
      extraGroups = ["docker" "libvirtd" "networkmanager" "tss" "wheel"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        user.primary.sshPublicKey
      ];
    };
  };
}
