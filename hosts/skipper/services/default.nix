_: {
  imports = [ ./keyd.nix ];
  services = {
    cpupower-gui.enable = true;
    thermald.enable = true;
    upower.enable = true;
  };
}
