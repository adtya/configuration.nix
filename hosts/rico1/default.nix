_: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./containers
    ./network

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

  i18n = {
    defaultLocale = "en_IN";
    extraLocales = [ "en_US.UTF-8" ];
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
