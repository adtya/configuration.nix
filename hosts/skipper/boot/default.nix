{ lib, pkgs, ... }: {
  imports = [ ./plymouth.nix ];
  environment = {
    systemPackages = with pkgs; [
      sbctl
    ];
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
}
