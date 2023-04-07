{ ... }: {
    programs.gnupg.agent = {
      enable = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

}
