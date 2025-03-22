{ pkgs, ... }:
let
  theme = {
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
  };
  iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
  };
  cursorTheme = {
    name = "Bibata-Modern-Amber";
    package = pkgs.bibata-cursors;
  };
in
{
  home.pointerCursor = cursorTheme // {
    gtk.enable = true;
    size = 24;
    x11.enable = true;
  };
  gtk = {
    enable = true;
    inherit theme cursorTheme iconTheme;
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
