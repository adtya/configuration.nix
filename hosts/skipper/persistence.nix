_: {
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/secureboot"
      "/etc/ssh/keys"
      "/etc/systemd/nspawn"
      "/etc/wireguard"
      "/var/cache/fwupd"
      "/var/lib/bluetooth"
      "/var/lib/btrfs"
      "/var/lib/docker"
      "/var/lib/flatpak"
      "/var/lib/fwupd"
      "/var/lib/iwd"
      "/var/lib/libvirt"
      "/var/lib/machines"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
      "/var/lib/portables"
      "/var/lib/systemd"
      "/var/lib/waydroid"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/u2f_keys"
    ];
  };
}
