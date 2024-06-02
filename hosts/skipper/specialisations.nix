{ lib
, pkgs
, ...
}:
let
  plymouth = theme: {
    enable = true;
    themePackages = lib.mkForce [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; })
    ];
    theme = lib.mkForce theme;
  };
in
{
  specialisation = {
    stable = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages;
          plymouth = plymouth "spinner_alt";
        };
      };
    };
    xanmod = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod;
          plymouth = plymouth "deus_ex";
        };
      };
    };
    zen = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
          plymouth = plymouth "flame";
        };
      };
    };
  };
}
