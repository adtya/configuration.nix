_: {
  programs.aria2 = {
    enable = true;
    settings = {
      continue = true;
      max-connection-per-server = 8;
      split = 8;
      min-split-size = "1M";
      file-allocation = "falloc";
      check-integrity = true;
      console-log-level = "warn";
      log-level = "notice";
      log = "-";
    };
  };
}
