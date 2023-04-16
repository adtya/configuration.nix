{ pkgs, ... }:
let
  user = import ../../users/user.nix;
in
{
  imports = [
    ./dbus.nix
    ./pipewire.nix
    ./tlp.nix
    ./udev.nix
  ];
  services = {
    blueman.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    geoclue2.enable = true;
    getty.autologinUser = user.primary.userName;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
    lvm.dmeventd.enable = true;
    pcscd.enable = true;
    resolved.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
  };
}
