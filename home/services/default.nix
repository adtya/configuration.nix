{ ... }: {
  imports = [
    ./gpg-agent.nix
    ./spotifyd.nix
  ];
  services = {
    gnome-keyring.enable = true;
  };
}
