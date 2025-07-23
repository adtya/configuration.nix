{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (steam.override {
      extraPkgs = p: [
        p.gamemode
        p.gamescope
        p.vulkan-tools
      ];
    })
    protonplus
  ];
}
