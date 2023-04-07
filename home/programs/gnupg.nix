{ ... }: {
  programs.gpg = {
    enable = true;
    settings = {
      keyserver = "hkps://keys.openpgp.org";
    };
    scdaemonSettings = {
      disable-ccid = true;
    };
  };
}
