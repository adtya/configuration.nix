_: {
  boot = {
    initrd.supportedFilesystems = [
      "vfat"
      "btrfs"
    ];
    supportedFilesystems = [
      "vfat"
      "btrfs"
      "ext4"
    ];
    consoleLogLevel = 3;
    initrd = {
      systemd.enable = true;
    };
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
    };
  };

}
