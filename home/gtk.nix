{ pkgs
, ...
}:
let
  gtkTheme = {
    name = "Dracula";
    package = pkgs.dracula-gtk;
  };

  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme.override { color = "black"; };
  };

  cursorTheme = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
in
{
  home.pointerCursor = cursorTheme // { gtk.enable = true; size = 24; };
  gtk = {
    enable = true;
    theme = gtkTheme;
    inherit cursorTheme;
    inherit iconTheme;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  home.sessionVariables.GTK_THEME = gtkTheme.name;
  xdg.configFile = {
    "gtk-4.0/assets".source = "${gtkTheme.package}/share/themes/${gtkTheme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${gtkTheme.package}/share/themes/${gtkTheme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${gtkTheme.package}/share/themes/${gtkTheme.name}/gtk-4.0/gtk-dark.css";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":appmenu";
    };
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };
}
