_: {
  dconf.settings = {
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };
  programs = {
    fd = {
      enable = true;
      ignores = [ ".git/" "node_modules/" ];
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
