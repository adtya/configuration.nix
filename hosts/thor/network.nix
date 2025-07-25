_: {
  networking = {
    wireless.iwd = {
      settings = {
        General = {
          ControlPortOverNL80211 = false; # Needed for iwd to work with ath12k
        };
      };
    };
  };
}
