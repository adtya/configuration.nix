_: {
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      compression = true;
    };
  };
}
