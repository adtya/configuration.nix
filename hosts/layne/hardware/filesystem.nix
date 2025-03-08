_: {
  boot = {
    initrd.supportedFilesystems = [ "vfat" "btrfs" ];
    supportedFilesystems = [ "vfat" "btrfs" "ext4" "exfat" ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/LAYNE_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-partlabel/LAYNE_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-partlabel/LAYNE_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/mnt/system" = {
      device = "/dev/disk/by-partlabel/LAYNE_ROOT";
      fsType = "btrfs";
      options = [ "subvol=/" "compress=zstd" "noatime" ];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-uuid/524bc3e3-d2be-4f56-b124-1ef1ef3afa81";
      fsType = "btrfs";
      options = [ "subvol=/" "compress=zstd" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-partlabel/LAYNE_BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-partlabel/LAYNE_SWAP"; }
  ];
}
