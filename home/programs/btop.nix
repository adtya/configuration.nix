{ ... }: {

  xdg.desktopEntries."btop" = {
    name = "btop++";
    exec = "btop";
    noDisplay = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
      vim_keys = true;
      update_ms = 1000;
    };
  };
}
