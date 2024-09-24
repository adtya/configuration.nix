{ lib
, pkgs
, ...
}: {
  imports = [ ./filesystem.nix ];

  boot = {
    consoleLogLevel = 3;
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
    kernelParams = [ "quiet" ];
    kernelModules = [ "kvm-intel" ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ "i915" "dm-snapshot" ];
      systemd.enable = true;
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
      enable32Bit = true;
      extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt libvdpau-va-gl ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver libvdpau-va-gl ];
    };
    sensor.hddtemp = {
      enable = true;
      drives = [ "/dev/disk/by-path/pci-0000:01:00.0-nvme-1" ];
    };
    xone.enable = true;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
