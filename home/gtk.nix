{ pkgs, ... }:
let
  theme = {
    name = "Dracula";
    package = pkgs.dracula-theme;
  };
  iconTheme = {
    name = "Dracula";
    package = pkgs.dracula-icon-theme;
  };
  cursorTheme = {
    name = "Bibata-Modern-Amber";
    package = pkgs.bibata-cursors;
  };
in
{
  home.packages = [ theme.package ];
  home.pointerCursor = cursorTheme // {
    gtk.enable = true;
    size = 24;
    x11.enable = true;
  };
  gtk = {
    enable = true;
    inherit cursorTheme iconTheme;
    theme = {
      inherit (theme) name;
      package = null;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = ":appmenu";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";
      gtk-xft-rgba = "rgb";
      gtk-recent-files-enabled = false;
    };
  };

  home.sessionVariables.GTK_THEME = theme.name;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-antialiasing = "rgba";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":appmenu";
    };
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };
}
