{ lib, pkgs, ... }:
{
  imports = [ ./filesystem.nix ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_testing;
    kernelModules = [ "kvm-amd" ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "sd_mod"
        "usbhid"
        "usb_storage"
      ];
      kernelModules = [
        "amdgpu"
        "dm-snapshot"
      ];
    };
  };
  environment.sessionVariables.VDPAU_DRIVER = "radeonsi";

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
          KernelExperimental = true;
        };
      };
      package = pkgs.bluez.override { enableExperimental = true; };
    };
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
