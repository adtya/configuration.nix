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
      auto-optimise = true;
      auto-gc = true;
      is-laptop = true;
      disable-channels  = true;
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
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
