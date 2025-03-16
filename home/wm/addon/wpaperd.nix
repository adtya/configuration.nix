{ config, pkgs, ... }:
{
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "10m";
        mode = "stretch";
        sorting = "random";
        path = "${config.xdg.userDirs.pictures}/Wallpapers";
      };
    };
  };
}
