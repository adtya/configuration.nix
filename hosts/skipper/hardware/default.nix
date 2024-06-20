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
    opengl = {
      enable = true;
      extraPackages = [ pkgs.intel-media-driver ];
      driSupport = true;
      driSupport32Bit = true;
    };
    sensor.hddtemp = {
      enable = true;
      drives = [ "/dev/disk/by-path/pci-0000:01:00.0-nvme-1" ];
    };
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
