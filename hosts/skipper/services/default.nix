_: {
  imports = [ ./keyd.nix ];
  services = {
    cpupower-gui.enable = true;
    logind.settings = {
      Login = {
        HandlePowerKey = "ignore";
      };
    };
    thermald.enable = true;
    upower.enable = true;
  };
}
