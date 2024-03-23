{ pkgs
, secrets
, ...
}:
let
  inherit (secrets) users;
in
{
  users.mutableUsers = false;
  users.users = {
    root = {
      inherit (users.root) hashedPassword;
    };
    "${users.primary.userName}" = {
      uid = 1000;
      inherit (users.primary) hashedPassword;
      description = users.primary.realName;
      isNormalUser = true;
      extraGroups = [ "docker" "libvirtd" "networkmanager" "tss" "wheel" ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        users.primary.sshPublicKey
        secrets.phone.sshPublicKey
      ];
    };
  };
}
