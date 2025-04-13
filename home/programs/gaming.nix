{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.mangohud
        p.vulkan-tools
      ];
    })
    (steam.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.mangohud
        p.vulkan-tools
      ];
    })
    protonplus
  ];
}
