_: {
  location.provider = "geoclue2";
  services.geoclue2 = {
    enable = true;
    enable3G = false;
    enableCDMA = false;
    enableNmea = false;
    enableWifi = true;
    enableModemGPS = false;
    enableDemoAgent = false;
    geoProviderUrl = "https://beacondb.net/v1/geolocate";
  };
}
