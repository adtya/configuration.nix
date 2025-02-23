{ config, username, ... }: {
  imports = [
    ./btrfs.nix
    ./dbus.nix
    ./geoclue.nix
    ./keyd.nix
    ./pipewire.nix
    ./udev.nix
    ./ssh.nix
  ];
  services = {
    cpupower-gui.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    getty.autologinUser = config.users.users.${username}.name;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    irqbalance.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };
}
