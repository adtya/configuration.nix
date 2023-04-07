{ lib, pkgs, ... }: {
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
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [ "quiet" ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
