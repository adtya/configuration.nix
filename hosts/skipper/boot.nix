{ pkgs, lib, ... }:
{
  environment = {
    systemPackages = with pkgs; [ sbctl ];
  };
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
    };
  };
}
