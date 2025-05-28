_: {
  imports = [
    ./btrfs.nix
    ./dbus.nix
    ./geoclue.nix
    ./pipewire.nix
    ./ssh.nix
    ./udev.nix
  ];
  services = {
    cpupower-gui.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    irqbalance.enable = true;
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };
}
