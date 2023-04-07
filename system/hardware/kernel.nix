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
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    kernelParams = [ "quiet" ];
    kernel.sysctl = {
      "vm.swappiness" = 0;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
