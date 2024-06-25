{ lib
, ...
}: {
  boot.supportedFilesystems = lib.mkForce [ "vfat" "btrfs" "ext4" "tmpfs" ];
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
