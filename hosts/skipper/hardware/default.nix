{ pkgs, lib, ... }:
{
  imports = [ ./filesystem.nix ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "rtsx_pci_sdmmc"
        "xhci_pci"
        "thunderbolt"
        "nvme"
      ];
      kernelModules = [
        "i915"
        "dm-snapshot"
      ];
    };
  };

  environment.sessionVariables.VDPAU_DRIVER = "va_gl";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        libvdpau-va-gl
      ];
    };
    sensor.hddtemp = {
      enable = true;
      drives = [ "/dev/disk/by-path/pci-0000:01:00.0-nvme-1" ];
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
