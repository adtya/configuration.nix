_: {
  imports = [ ./disko.nix ];
  boot = {
    initrd = {
      supportedFilesystems = [ "vfat" "btrfs" ];
      luks.devices = {
        luks0 = {
          allowDiscards = true;
          bypassWorkqueues = true;
          device = "/dev/disk/by-partlabel/CRYPT";
        };
      };
    };
    supportedFilesystems = [ "vfat" "btrfs" "ext4" "exfat" "ntfs" ];
  };
}
