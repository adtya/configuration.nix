_: {
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/btrfs"
      "/var/lib/iwd"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/systemd"
      "/var/lib/tailscale"
      "/var/log"
    ];
    files = [ "/etc/machine-id" ];
  };
}
