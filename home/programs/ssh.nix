_: {
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "yes";
    hashKnownHosts = true;
  };
}
