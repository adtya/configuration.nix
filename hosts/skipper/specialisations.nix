{
  lib,
  pkgs,
  ...
}: {
  specialisation = {
    xanmod = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
        system.nixos.tags = ["with-xanmod"];
      };
    };
    vanilla = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
        system.nixos.tags = ["with-vanilla"];
      };
    };
  };
}
