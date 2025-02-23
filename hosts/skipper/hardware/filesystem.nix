_: {
  imports = [ ./disko.nix ];
  boot = {
    initrd = {
      supportedFilesystems = [ "vfat" "btrfs" ];
    };
    supportedFilesystems = [ "vfat" "btrfs" "ext4" "exfat" "ntfs" ];
  };
}
