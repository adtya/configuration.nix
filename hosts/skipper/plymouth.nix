{pkgs, ...}: {
  boot.plymouth = {
    enable = true;
    themePackages = [
      (pkgs.adi1090x-plymouth.override {
        pack = "pack_3";
        theme = "infinite_seal";
      })
    ];
    theme = "adi1090x";
  };
}
