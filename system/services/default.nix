{ pkgs, ... }: {

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
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    lvm.dmeventd.enable = true;
    pcscd.enable = true;
    resolved.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
  };
  security.pam.services = {
    passwd.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
    swaylock = { };
  };
}
