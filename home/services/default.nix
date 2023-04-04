{ ... }: {
  imports = [
    ./media.nix
  ];
  services.blueman-applet.enable = true;
  services.gnome-keyring.enable = true;
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    enableScDaemon = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };
}
