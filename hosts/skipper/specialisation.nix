{ pkgs, ... }: {
  specialisation = {
    linux_lts = {
      configuration = {
        boot.kernelPackages = pkgs.linuxPackages;
      };
    };
  };
}
