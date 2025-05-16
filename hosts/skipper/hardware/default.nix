{ lib, pkgs, ... }:
{
  imports = [
    ./filesystem.nix
    ./keyboard.nix
  ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [
        "i915"
        "dm-snapshot"
      ];
    };
  };

  hardware = {
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
    cpu.intel.updateMicrocode = lib.mkDefault true;
    enableRedistributableFirmware = true;
    gpgSmartcards.enable = true;
    graphics = {
      enable = true;
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
    xone.enable = true;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
