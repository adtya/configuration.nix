_: {
  environment.persistence."/persist/state" = {
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
      {
        directory = "/var/lib/containers";
        mode = "0700";
        user = "root";
        group = "root";
      }
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
