{ lib
, pkgs
, ...
}: {
  specialisation = {
    xanmod = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
        };
        system.nixos.tags = [ "with-xanmod" ];
      };
    };
    zen = {
      inheritParentConfig = true;
      configuration = {
        boot = {
          kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
        };
        system.nixos.tags = [ "with-zen" ];
      };
    };
  };
}
