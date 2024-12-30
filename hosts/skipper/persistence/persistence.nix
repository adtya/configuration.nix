_:
let persistant-path = "/persist/system"; in {
  environment = {
    etc = {
      "machine-id" = {
        enable = true;
        source = "${persistant-path}/machine-id";
        mode = "symlink";
      };
    };
    persistence."${persistant-path}" = {
      hideMounts = true;
      directories = [
        "/etc/systemd/nspawn"
        "/root/.local/share/nix"
        "/var/cache/fwupd"
        "/var/lib/bluetooth"
        "/var/lib/btrfs"
        "/var/lib/fwupd"
        "/var/lib/iwd"
        "/var/lib/libvirt"
        "/var/lib/machines"
        "/var/lib/nixos"
        "/var/lib/portables"
        "/var/lib/systemd"
        "/var/lib/tailscale"
        "/var/log"
      ];
    };
  };
}
