_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      compression = true;
      forwardAgent = false;
      addKeysToAgent = "no";
      hashKnownHosts = true;
      userKnownHostsFile = "~/.ssh/known_hosts";
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      controlPath = "~/.ssh/master-%r@%n:%p";
    };
  };
}
