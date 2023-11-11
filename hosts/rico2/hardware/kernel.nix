{ lib
, pkgs
, ...
}: {
  boot = {
    initrd = {
      systemd.enable = true;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
