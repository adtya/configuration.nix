{ lib, pkgs, ... }:
{
  imports = [ ./disko.nix ];

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
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    graphics.enable32Bit = true;
  };
}
