_: {
  imports = [
    ./dbus.nix
    ./geoclue.nix
    ./pipewire.nix
    ./udev.nix
  ];
  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
  };
}
