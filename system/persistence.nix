{ ... }: {
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/secureboot"
      "/root/.cache/nix"
      "/var/cache/apparmor"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/iwd"
      "/var/lib/libvirt"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
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
