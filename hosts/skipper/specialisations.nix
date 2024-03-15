{ lib
, pkgs
, ...
}:
let
  plymouth = let theme = "angular_alt"; in {
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
          inherit plymouth;
        };
      };
    };
    zen = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
          inherit plymouth;
        };
      };
    };
  };
}
