_: {
  imports = [ ./filesystem.nix ./kernel.nix ];

  hardware.enableRedistributableFirmware = true;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    supportedFilesystems = [ "vfat" "btrfs" "ext4" ];
  };
}
