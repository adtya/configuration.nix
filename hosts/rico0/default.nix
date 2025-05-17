_: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./containers
    ./network

    ../shared/locale.nix
    ../shared/users.nix
  ];

  nodeconfig = {
    minimize = true;
    nix = {
      auto-optimise = true;
      auto-gc = true;
      is-laptop = true;
      disable-channels = true;
      cool-features = true;
      trust-wheel = true;
      enable-extra-substituters = true;
    };
    is-pi = true;
    is-server = true;
    facts = {
      local-ip = "192.168.1.10";
      tailscale-ip = "100.69.69.10";
    };
    sudo = {
      enable = true;
      primary-user-is-wheel = true;
      wheel-is-god = true;
    };
  };

  time.timeZone = "Asia/Kolkata";
  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    stateVersion = "23.11";
  };
}
