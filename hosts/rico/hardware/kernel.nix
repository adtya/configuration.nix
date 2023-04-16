{ lib, pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "usbhid"
        "usb_storage"
      ];
      systemd.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
