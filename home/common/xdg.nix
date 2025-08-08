{ config, ... }:
{
  home.preferXdgDirectories = true;
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;

    userDirs = {
      enable = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };

    desktopEntries."nixos-manual" = {
      name = "NixOS Manual";
      exec = "nixos-help";
      noDisplay = true;
    };
  };
}
