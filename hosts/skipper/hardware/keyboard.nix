{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.via ];
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];
}
