{ lib
, pkgs
, ...
}: {
  boot = {
    consoleLogLevel = 3;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ "i915" "dm-snapshot" ];
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
