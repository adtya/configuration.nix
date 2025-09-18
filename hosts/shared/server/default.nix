{ lib, ... }:
{
  imports = [
    ./programs
    ./services
    ./network.nix
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
    sudo = {
      enable = true;
      primary-user-is-wheel = true;
      wheel-is-god = true;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  systemd = {
    settings.Manager = {
      KExecWatchdogSec = "1m";
      RebootWatchdogSec = "30s";
      RuntimeWatchdogSec = "15s";
    };
    enableEmergencyMode = false;
    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
    '';
  };

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
