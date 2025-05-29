{ pkgs, ... }:
{
  imports = [ ./filesystem.nix ];
  hardware = {
    amdgpu = {
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
      initrd.enable = true;
    };
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
    };
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
