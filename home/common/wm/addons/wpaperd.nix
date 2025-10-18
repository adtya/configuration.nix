{ config, ... }:
{
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "10m";
        mode = "center";
        sorting = "random";
        path = "${config.xdg.userDirs.pictures}/Wallpapers/1080p";
      };
      DP-1 = {
        path = "${config.xdg.userDirs.pictures}/Wallpapers/1440p";
      };
    };
  };
}
