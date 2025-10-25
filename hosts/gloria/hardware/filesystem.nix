_: {
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/mnt/system" ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0a94c3a0-470f-466c-9e70-9013c25c7b6d";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/0a94c3a0-470f-466c-9e70-9013c25c7b6d";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/0a94c3a0-470f-466c-9e70-9013c25c7b6d";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd"
        "relatime"
      ];
      neededForBoot = true;
    };

    "/mnt/system" = {
      device = "/dev/disk/by-uuid/0a94c3a0-470f-466c-9e70-9013c25c7b6d";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "relatime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7954-CBB9";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
}
