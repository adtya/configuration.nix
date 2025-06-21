_: {
  imports = [
    ./hardware
    ./programs
    ./services
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
    is-server = true;
    facts = {
      local-ip = "192.168.1.13";
      tailscale-ip = "100.69.69.13";
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
