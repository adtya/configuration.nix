_: {
  programs.gnupg.agent = {
    enable = true;
    enableExtraSocket = true;
    pinentryFlavor = "gnome3";
  };
}
