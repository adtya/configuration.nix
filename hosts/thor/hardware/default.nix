{ lib, pkgs, ... }:
{
  imports = [ ./filesystem.nix ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelModules = [
      "kvm-amd"
      "ntsync"
    ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "thunderbolt"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  environment.sessionVariables.VDPAU_DRIVER = "radeonsi";

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    graphics.enable32Bit = true;
    steam-hardware.enable = true;
    xone.enable = true;
    xpad-noone.enable = lib.mkForce false;
  };
}
