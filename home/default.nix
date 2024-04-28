_: {
  imports = [ ./programs ./services ./wm ./gtk.nix ./qt.nix ./persistence.nix ];

  home.stateVersion = "23.11";

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "image/gif" = [ "org.gnome.Loupe.desktop" ];
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "image/webp" = [ "org.gnome.Loupe.desktop" ];
        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
        "x-scheme-handler/magnet" = [ "io.github.TransmissionRemoteGtk.desktop" ];
      };
    };
    userDirs.enable = true;

    desktopEntries."nixos-manual" = {
      name = "NixOS Manual";
      exec = "nixos-help";
      noDisplay = true;
    };
  };
}
