{
  lib,
  pkgs,
  ...
}: {
  specialisation = {
    xanmod = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
        system.nixos.tags = ["with-xanmod"];
      };
    };
    vanilla = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
        system.nixos.tags = ["with-vanilla"];
      };
    };
  };
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
      kernelModules = ["i915"];
      systemd.enable = true;
    };
    kernelModules = ["kvm-intel"];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
    kernelParams = ["quiet"];
    kernel.sysctl = {
      "vm.swappiness" = 0;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
