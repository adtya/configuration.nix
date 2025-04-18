{ lib, pkgs, ... }:
{
  imports = [ ./filesystem.nix ];

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        libvdpau-va-gl
      ];
    };
  };

  boot = {
    consoleLogLevel = 4;
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ "i915" ];
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelParams = [
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
