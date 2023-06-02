{...}: {
  imports = [./programs ./services ./wm ./gtk.nix ./persistence.nix];

  home.stateVersion = "23.11";

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.userDirs.enable = true;

  xdg.desktopEntries."nixos-manual" = {
    name = "NixOS Manual";
    exec = "nixos-help";
    noDisplay = true;
  };
}
