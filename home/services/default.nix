{ ... }: {
  imports = [
    ./gpg-agent.nix
    ./spotifyd.nix
  ];
  services = {
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };
}
