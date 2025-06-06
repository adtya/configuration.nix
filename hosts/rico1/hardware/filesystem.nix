_: {
  boot = {
    initrd.supportedFilesystems = [
      "vfat"
      "btrfs"
    ];
    supportedFilesystems = [
      "vfat"
      "btrfs"
      "ext4"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress-force=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress-force=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress-force=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };

    "/mnt/system" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=/"
        "compress-force=zstd"
        "noatime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-partlabel/RICO1_BOOT";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
}
