{ ... }: {
  imports = [
    ./aria2c.nix
    ./gpg-agent.nix
    ./spotifyd.nix
  ];
  services = {
    gnome-keyring.enable = true;
  };
}
