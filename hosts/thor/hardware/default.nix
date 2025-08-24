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
      overdrive.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    graphics.enable32Bit = true;
  };
}
