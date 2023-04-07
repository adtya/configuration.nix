{ ... }: {
  services = {
    imports = [
      ./gpg-agent.nix
      ./spotifyd.nix
    ];
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };
}
