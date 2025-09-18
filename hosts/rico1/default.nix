_: {
  imports = [
    ./services
    ./filesystem.nix
  ];
  nodeconfig = {
    facts = {
      local-ip = "192.168.1.11";
      tailscale-ip = "100.69.69.11";
    };
  };

  system.stateVersion = "23.11";
}
