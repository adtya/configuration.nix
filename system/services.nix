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
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    lvm.dmeventd.enable = true;
    pcscd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    resolved.enable = true;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC="performance";
        CPU_SCALING_GOVERNOR_ON_BAT="powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC="performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT="power";

        CPU_MAX_PERF_ON_AC=100;
        CPU_MAX_PERF_ON_BAT=60;

        CPU_BOOST_ON_AC=1;
        CPU_BOOST_ON_BAT=0;
      };
    };
    udev.packages = [ pkgs.yubikey-personalization ];
    udisks2.enable = true;
  };
  security.pam.services = {
    passwd.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
    swaylock = { };
  };
}
