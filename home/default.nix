_: {
  imports = [./programs ./services ./wm ./gtk.nix ./persistence.nix];

  home.stateVersion = "23.11";

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/gif" = ["org.gnome.eog.desktop"];
      "image/jpeg" = ["org.gnome.eog.desktop"];
      "image/png" = ["org.gnome.eog.desktop"];
      "image/webp" = ["org.gnome.eog.desktop"];
    };
  };
  xdg.userDirs.enable = true;

  xdg.desktopEntries."nixos-manual" = {
    name = "NixOS Manual";
    exec = "nixos-help";
    noDisplay = true;
  };
}
