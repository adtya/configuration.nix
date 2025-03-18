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
    };
  };

  home.sessionVariables.GTK_THEME = theme.name;
  xdg.configFile = {
    "gtk-4.0/assets".source = "${theme.package}/share/themes/${theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${theme.package}/share/themes/${theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${theme.package}/share/themes/${theme.name}/gtk-4.0/gtk-dark.css";
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
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };
}
