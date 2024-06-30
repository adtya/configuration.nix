_: {
  imports = [ ./nix.nix ./users.nix ];

  sops = {
    defaultSopsFile = ../secrets.yaml;
  };
}
