_: {
  networking = {
    wireless.iwd = {
      settings = {
        General = {
          # https://bugzilla.kernel.org/show_bug.cgi?id=218733
          ControlPortOverNL80211 = false;
        };
      };
    };
  };
}
