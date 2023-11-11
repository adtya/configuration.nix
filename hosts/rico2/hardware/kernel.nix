{ lib
, pkgs
, ...
}: {
  boot = {
    initrd = {
      availableKernelModules = [
        "usbhid"
        "usb_storage"
      ];
      systemd.enable = true;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
