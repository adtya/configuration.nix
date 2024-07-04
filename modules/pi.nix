{ lib, config, pkgs, ... }:
let cfg = config.nodeconfig; in {
  options.nodeconfig = {
    is-pi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Is the node a Raspberry Pi?";
    };
  };

  config = lib.mkIf cfg.is-pi {
    # https://github.com/NixOS/nixpkgs/issues/126755#issuecomment-869149243
    nixpkgs.overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];

    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi4;
      initrd.availableKernelModules = [ "xhci_pci" ];
    };

    environment.systemPackages = with pkgs; [
      libraspberrypi
      raspberrypi-eeprom
    ];

    hardware.enableRedistributableFirmware = true;
  };
}
