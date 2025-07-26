{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./virt-manager.nix
  ];

  home.packages = [ pkgs.piper ];
}
