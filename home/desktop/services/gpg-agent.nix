{ ... }: {
  services = {
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
    };
  };
}
