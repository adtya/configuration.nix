{ pkgs, ... }:
{
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
    enableRedistributableFirmware = true;
    graphics.enable = true;
    keyboard.qmk.enable = true;
  };
}
