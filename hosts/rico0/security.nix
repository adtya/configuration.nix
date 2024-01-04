_: {
  security = {
    apparmor = {
      enable = true;
      enableCache = true;
    };
    audit.enable = true;
    auditd.enable = true;
    sudo = {
      wheelNeedsPassword = false;
    };
    polkit.enable = true;
    rtkit.enable = true;
  };
}
