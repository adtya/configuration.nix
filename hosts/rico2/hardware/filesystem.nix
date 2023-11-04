_: {
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/NIXOS_ROOT";
    fsType = "btrfs";
    options = [ "noatime" "compress=zstd" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/ESP";
    fsType = "vfat";
  };
}
