_: {
  systemd.network.links = {
    "40-ether" = {
      matchConfig = {
        Type = "ether";
      };

      linkConfig = {
        NamePolicy = [
          "keep"
          "kernel"
          "database"
          "onboard"
          "slot"
          "path"
        ];
        AlternativeNamesPolicy = [
          "database"
          "onboard"
          "slot"
          "path"
          "mac"
        ];
        MACAddressPolicy = "persistent";
        WakeOnLan = "magic";
      };

    };
  };
}
