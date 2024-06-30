_: {
  boot = {
    initrd = {
      supportedFilesystems = [ "vfat" "btrfs" ];
      luks.devices = {
        luks0 = {
          allowDiscards = true;
          bypassWorkqueues = true;
          device = "/dev/disk/by-partlabel/CRYPT";
          preLVM = true;
        };
      };
    };
    supportedFilesystems = [ "vfat" "ntfs" "exfat" "ext4" "btrfs" ];
    resumeDevice = "/dev/vg0/swap";
  };
  fileSystems = {
    "/" = {
      device = "/dev/vg0/system";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };
    "/home" = {
      device = "/dev/vg0/system";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress-force=zstd" "noatime" ];
    };
    "/nix" = {
      device = "/dev/vg0/system";
      fsType = "btrfs";
      options = [ "subvol=/@nix" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };
    "/persist" = {
      device = "/dev/vg0/system";
      fsType = "btrfs";
      options = [ "subvol=/@persist" "compress-force=zstd" "noatime" ];
      neededForBoot = true;
    };
    "/mnt/system" = {
      device = "/dev/vg0/system";
      fsType = "btrfs";
      options = [ "subvol=/" "compress-force=zstd" "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/ESP";
      fsType = "vfat";
    };
  };

  swapDevices = [{ device = "/dev/vg0/swap"; }];
}
