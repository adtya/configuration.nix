{ lib, pkgs, ... }:
{
  imports = [ ./disko.nix ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_testing;
    kernelParams = [ "amd_pstate=active" ];
    kernelModules = [
      "kvm-amd"
      "ntsync"
    ];
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
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [ "L+    /opt/rocm   -    -    -     -    ${rocmEnv}" ];

  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    graphics.enable32Bit = true;
  };
}
