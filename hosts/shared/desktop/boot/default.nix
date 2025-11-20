_:
{
  imports = [ ./plymouth.nix ];
  boot = {
    bootspec.enable = true;
    consoleLogLevel = 3;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" ];
    kernel.sysctl = {
      "vm.dirty_ratio" = 3;
    };
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
  };
}
