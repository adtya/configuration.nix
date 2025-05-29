_: {
  imports = [ ./disko.nix ];
  boot = {
    initrd = {
      supportedFilesystems = [
        "vfat"
        "btrfs"
      ];
    };
    supportedFilesystems = [
      "vfat"
      "exfat"
      "ext4"
      "btrfs"
    ];
  };
}
