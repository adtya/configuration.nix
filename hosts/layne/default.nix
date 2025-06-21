_: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./network
    ./users.nix

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

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "24.05";
}
