{secrets, ...}: let
  user = secrets.users;
in {
  imports = [
    ./dbus.nix
    ./pipewire.nix
    ./udev.nix
    ./ssh.nix
  ];
  services = {
    blueman.enable = true;
    cpupower-gui.enable = true;
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
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    udisks2.enable = true;
  };
}
