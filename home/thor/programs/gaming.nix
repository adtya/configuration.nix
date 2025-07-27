{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (steam.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.mangohud
        p.vulkan-tools
      ];
    })
  ];
}
