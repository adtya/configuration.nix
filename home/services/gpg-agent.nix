_: {
  services = {
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      pinentryFlavor = "gnome3";
    };
  };
}
