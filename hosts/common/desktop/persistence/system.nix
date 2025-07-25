_: {
  environment.persistence."/persist/state" = {
    hideMounts = true;
    directories = [
      {
        directory = "/var/lib/bluetooth";
        user = "root";
        group = "root";
        mode = "0700";
      }
      {
        directory = "/var/lib/containers";
        user = "root";
        group = "root";
        mode = "0700";
      }
      {
        directory = "/var/lib/iwd";
        user = "root";
        group = "root";
        mode = "0700";
      }
      {
        directory = "/var/lib/private";
        user = "root";
        group = "root";
        mode = "0700";
      }
      {
        directory = "/var/lib/tailscale";
        user = "root";
        group = "root";
        mode = "0700";
      }
      "/var/lib/btrfs"
      "/var/lib/cni"
      "/var/lib/flatpak"
      "/var/lib/libvirt"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/systemd"
      "/var/log"
    ];
    files = [ "/etc/machine-id" ];
  };
}
