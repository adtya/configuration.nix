{pkgs, ...}: {
  home.packages = [pkgs.gnome.nautilus];
  dconf.settings = {
    "io/elementary/files/preferences" = {
      singleclick-select = true;
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gnome/nautilus/preferences" = {
      click-policy = "double";
    };
  };
}
