{ lib
, pkgs
, config
, ...
}: {
  imports = [ ./kernel.nix ./filesystem.nix ];

  boot = {
    resumeDevice = "/dev/vg0/swap";
    initrd.luks.devices = {
      luks0 = {
        allowDiscards = true;
        bypassWorkqueues = true;
        device = "/dev/disk/by-partlabel/CRYPT";
        preLVM = true;
      };
    };
  };

  swapDevices = [{ device = "/dev/vg0/swap"; }];

  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
    driSupport = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    enableRedistributableFirmware = true;
  };

  hardware.bluetooth = {
    settings = {
      General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
    package = (pkgs.bluez.override { withExperimental = true; });
    enable = true;
  };

  hardware.sensor.hddtemp = {
    enable = true;
    drives = [ "/dev/disk/by-path/pci-0000:01:00.0-nvme-1" ];
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
  };
}
