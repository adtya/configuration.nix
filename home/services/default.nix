_: {
  imports = [
    ./gpg-agent.nix
    ./transmission.nix
  ];
  services = {
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };
}
