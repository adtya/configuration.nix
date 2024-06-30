{ lib
, pkgs
, ...
}: {
  imports = [ ./kernel.nix ./filesystem.nix ];

  boot = {
    initrd = {
      luks.devices = {
        luks0 = {
          allowDiscards = true;
          bypassWorkqueues = true;
          device = "/dev/disk/by-partlabel/CRYPT";
          preLVM = true;
        };
      };
      supportedFilesystems = [ "vfat" "btrfs" ];
    };
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/vg0/swap";
    supportedFilesystems = [ "vfat" "ntfs" "exfat" "ext4" "btrfs" ];
  };

  swapDevices = [{ device = "/dev/vg0/swap"; }];

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
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
