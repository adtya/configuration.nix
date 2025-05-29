_: {
  imports = [
    ./btrfs.nix
    ./dbus.nix
    ./geoclue.nix
    ./pipewire.nix
    ./ssh.nix
  ];
  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    udev.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };
}
