{ pkgs, ... }:
{
  imports = [ ./plymouth.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
      kernelModules = [
        "dm-snapshot"
        "amdgpu"
      ];
    };
    bootspec.enable = true;
    consoleLogLevel = 3;
    kernelParams = [
      "amd_pstate=active"
      "quiet"
    ];
    kernel.sysctl = {
      "vm.dirty_ratio" = 3;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
