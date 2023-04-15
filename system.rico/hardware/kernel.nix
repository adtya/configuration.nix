{ lib, pkgs, ... }: {
  boot = {
    consoleLogLevel = 3;
    initrd = {
      availableKernelModules = [
        "usbhid"
        "usb_storage"
      ];
      systemd.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
