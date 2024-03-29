_: {
  imports = [ ./programs ./services ./wm ./gtk.nix ./persistence.nix ];

  home.stateVersion = "23.11";

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "image/gif" = [ "org.gnome.eog.desktop" ];
        "image/jpeg" = [ "org.gnome.eog.desktop" ];
        "image/png" = [ "org.gnome.eog.desktop" ];
        "image/webp" = [ "org.gnome.eog.desktop" ];
        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
        "x-scheme-handler/magnet" = [ "transmission-gtk.desktop" ];
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
