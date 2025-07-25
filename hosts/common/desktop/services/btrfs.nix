_: {
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/mnt/system" ];
  };
}
