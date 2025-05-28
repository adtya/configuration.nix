{ pkgs, ... }:
{
  imports = [ ./filesystem.nix ];
  hardware = {
    amdgpu.initrd.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
      package = pkgs.bluez.override { enableExperimental = true; };
    };
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs.driversi686Linux; [ amdvlk ];
    };
    xone.enable = true;
  };
}
