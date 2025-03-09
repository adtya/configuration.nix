{ lib, pkgs, ... }: {
  imports = [ ./plymouth.nix ];
  environment = {
    systemPackages = with pkgs; [
      sbctl
    ];
  };
  boot = {
    bootspec.enable = true;
    consoleLogLevel = 3;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.dirty_ratio" = 3;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = lib.mkForce false;
      timeout = 0;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/secrets/secureboot";
    };
  };
}
