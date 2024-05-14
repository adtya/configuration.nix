_: {
  imports = [ ./programs ./services ./wm ./gtk.nix ./qt.nix ./persistence.nix ];

  home.stateVersion = "23.11";

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
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
