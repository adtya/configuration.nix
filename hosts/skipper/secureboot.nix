{ lib
, pkgs
, ...
}: {
  environment.etc."secureboot" = {
    mode = "symlink";
    source = "/persist/secrets/secureboot";
  };
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = lib.mkForce false;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/secrets/secureboot";
    };
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
