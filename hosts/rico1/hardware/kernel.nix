{ lib
, ...
}: {
  boot.supportedFilesystems = lib.mkForce [ "vfat" "btrfs" "ext4" ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
