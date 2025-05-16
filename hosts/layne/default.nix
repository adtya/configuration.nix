_: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./network
    ./users.nix

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
    is-server = true;
    facts = {
      local-ip = "192.168.1.14";
    };
    sudo = {
      enable = true;
      primary-user-is-wheel = true;
      wheel-is-god = true;
    };
  };

  environment.sessionVariables = {
    VDPAU_DRIVER = "va_gl";
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
    stateVersion = "24.05";
  };
}
