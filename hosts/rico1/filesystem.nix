_: {
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/mnt/system" ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress-force=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress-force=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress-force=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/mnt/system" = {
      device = "/dev/disk/by-partlabel/RICO1_ROOT";
      fsType = "btrfs";
      options = [
        "subvol=/"
        "compress-force=zstd"
        "relatime"
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
