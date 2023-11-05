{ pkgs, ... }: {
  specialisation = {
    linux_lts = {
      configuration = {
        boot.kernelPackages = pkgs.linuxPackages;
        system.nixos.tags = [ "with-lts-kernel" ];
      };
    };
  };
}
