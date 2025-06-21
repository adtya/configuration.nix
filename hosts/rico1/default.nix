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
      auto-gc = true;
      auto-optimise = true;
      is-laptop = true;
      disable-channels = true;
      cool-features = true;
      trust-wheel = true;
      enable-extra-substituters = true;
    };
    is-pi = true;
    is-server = true;
    facts = {
      local-ip = "192.168.1.11";
    };
    sudo = {
      enable = true;
      primary-user-is-wheel = true;
      wheel-is-god = true;
    };
  };

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "23.11";
}
