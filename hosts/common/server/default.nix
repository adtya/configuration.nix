_: {
  imports = [
    ./programs
    ./services
    ./boot.nix
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
    enableEmergencyMode = false;
    watchdog = {
      runtimeTime = "15s";
      rebootTime = "30s";
      kexecTime = "1m";
    };
    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
    '';
  };

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
