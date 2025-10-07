{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonplus
    (lutris.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.mangohud
        p.vulkan-tools
        p.wineWowPackages.waylandFull
      ];
    })
    (steam.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.mangohud
        p.vulkan-tools
        p.wineWowPackages.waylandFull
      ];
    })
  ];
}
