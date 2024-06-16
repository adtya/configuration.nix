{ lib
, pkgs
, ...
}: {
  boot = {
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/system/etc/secureboot";
    };
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
