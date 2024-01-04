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
      kernelModules = [ "i915" ];
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
