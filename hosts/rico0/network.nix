{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  networking = {
    hostName = "Rico0";

    networkmanager.enable = true;
    nameservers = [
      "2620:fe::fe"
      "9.9.9.9"
      "2620:fe::9"
      "149.112.112.112"
    ];

    useDHCP = lib.mkDefault false;
  };
}
