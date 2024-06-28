{ lib
, pkgs
, ...
}: {
  boot = {
    consoleLogLevel = 3;
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    initrd = {
    availableKernelModules = ["xhci_pci"];
    systemd.enable = true;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
