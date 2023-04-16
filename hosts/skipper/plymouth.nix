{ pkgs, ... }: {
  boot.plymouth = {
    enable = true;
    themePackages = [
      (pkgs.adi1090x-plymouth.override {
        pack = "pack_3";
        theme = "optimus";
      })
    ];
    theme = "adi1090x";
  };
}
