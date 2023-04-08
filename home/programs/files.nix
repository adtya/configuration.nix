{ pkgs, ... }: {
  home.packages = [ pkgs.pantheon.elementary-files ];
  dconf.settings = {
    "io/elementary/files/preferences" = {
      singleclick-select = true;
    };
  };
}
