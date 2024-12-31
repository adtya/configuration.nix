_: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./network
    ./security.nix
  ];

  nodeconfig = {
    minimize = true;
    nix.auto-gc = true;
    is-server = true;
    facts = {
      local-ip = "192.168.1.13";
      tailscale-ip = "100.69.69.13";
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
