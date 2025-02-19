_: {
  boot = {
    initrd.supportedFilesystems = [ "vfat" "btrfs" ];
    supportedFilesystems = [ "vfat" "btrfs" "ext4" ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/RICO2_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-partlabel/RICO2_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-partlabel/RICO2_ROOT";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/mnt/system" = {
      device = "/dev/disk/by-partlabel/RICO2_ROOT";
      fsType = "btrfs";
      options = [ "subvol=/" "compress-force=zstd" "noatime" ];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-partlabel/DATA1";
      fsType = "btrfs";
      options = [ "subvol=/" "compress-force=zstd" "noatime" "nofail" "x-systemd.automount" "x-systemd.device-timeout=5" ];
    };

    "/var/lib/private" = {
      device = "/dev/disk/by-partlabel/DATA1";
      fsType = "btrfs";
      options = [ "subvol=@state" "compress-force=zstd" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-partlabel/RICO2_BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };
}
