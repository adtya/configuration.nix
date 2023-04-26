{ lib, ... }: {
  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/vg0/system /mnt

    btrfs subvolume list -o /mnt |
      cut -f9 -d' ' |
      while read subvolume; do
        echo "deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
    echo "deleting /root subvolume..." &&
    btrfs subvolume delete "/mnt/@root"


    echo "restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/@root-blank /mnt/@root

    echo "deleting /home subvolume..."
    btrfs subvolume delete /mnt/@home

    echo "restoring blank /home subvolume..."
    btrfs subvolume snapshot /mnt/@home-blank /mnt/@home

    umount /mnt
  '';
}
