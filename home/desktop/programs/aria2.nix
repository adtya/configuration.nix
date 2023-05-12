{ ... }: {
  programs.aria2 = {
    enable = true;
    settings = {
      bt-require-crypto = true;
      bt-tracker = "udp://tracker.opentrackr.org:1337/announce";
      continue = true;
      max-connection-per-server = 8;
      split = 8;
      min-split-size = "1M";
      file-allocation = "falloc";
    };
  };
}
