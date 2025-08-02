_: {
  imports = [
    ./services
    ./filesystem.nix
  ];
  nodeconfig = {
    facts = {
      local-ip = "192.168.1.10";
      tailscale-ip = "100.69.69.10";
    };
  };

  system.stateVersion = "23.11";
}
