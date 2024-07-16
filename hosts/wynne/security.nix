_: {
  imports = [ ../shared/certs ];
  security = {
    sudo = {
      wheelNeedsPassword = false;
    };
    polkit.enable = true;
  };
}
