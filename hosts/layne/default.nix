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
      disable-channels  = true;
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
    stateVersion = "24.05";
  };
}
