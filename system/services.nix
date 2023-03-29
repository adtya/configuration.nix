{ pkgs, ... }: {
  services = {
    blueman.enable = true;
    dbus = {
      enable = true;
      apparmor = "enabled";
      packages = [ pkgs.gcr pkgs.gcr_4 ];
    };
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    lvm.dmeventd.enable = true;
    pcscd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    power-profiles-daemon.enable = true;
    resolved.enable = true;
    thermald.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    udisks2.enable = true;
  };
}
