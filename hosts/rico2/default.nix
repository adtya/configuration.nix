_: {
  imports = [ ./filesystem.nix ];
  nodeconfig = {
    facts = {
      local-ip = "192.168.1.12";
      tailscale-ip = "100.69.69.12";
    };
  };

  system.stateVersion = "23.11";
}
