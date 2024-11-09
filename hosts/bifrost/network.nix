{ lib, ... }: {
  imports = [
    ../shared/network.nix
    ../shared/networkd.nix
  ];
  networking = {
    nameservers = lib.mkForce [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
