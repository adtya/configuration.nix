{pkgs, ...}: {
  boot.plymouth = {
    enable = true;
    themePackages = [
      (pkgs.adi1090x-plymouth.override {
        pack = "pack_4";
        theme = "rog_2";
      })
    ];
    theme = "adi1090x";
  };
}
