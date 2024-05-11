{ pkgs, ... }: {
  home.packages = [ pkgs.gnome.nautilus ];
  dconf.settings = {
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gnome/nautilus/preferences" = {
      click-policy = "double";
    };
  };
  programs.fd = {
    enable = true;
    ignores = [ ".git/" "node_modules/" ];
  };
}
