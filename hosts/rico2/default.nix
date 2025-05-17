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
      local-ip = "192.168.1.12";
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
