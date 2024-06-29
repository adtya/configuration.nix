{ lib, pkgs, ... }: {
  imports = [ ./filesystem.nix ];

  hardware.enableRedistributableFirmware = true;

  boot = {
    consoleLogLevel = 3;
    initrd = {
      availableKernelModules = [ "xhci_pci" ];
      systemd.enable = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi4;
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    supportedFilesystems = [ "vfat" "btrfs" "ext4" ];
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
