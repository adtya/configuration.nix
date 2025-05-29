_: {
  #imports = [ ./plymouth.nix ];

  boot = {
    kernelModules = [ "kvm-amd" ];
    initrd = {
      systemd.enable = true;
      verbose = false;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      kernelModules = [ "amdgpu" ];
    };
    bootspec.enable = true;
    consoleLogLevel = 3;
    kernelParams = [
      "amd_pstate=active"
      "quiet"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
