{ ... }: {
  services = {
    imports = [
      ./spotifyd.nix
    ];
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };
}
