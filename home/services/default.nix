_: {
  imports = [
    ./aria2c.nix
    ./gpg-agent.nix
  ];
  services = {
    gnome-keyring.enable = true;
  };
}
