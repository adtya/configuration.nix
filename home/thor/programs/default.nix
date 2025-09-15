{ pkgs, ... }:
{
  imports = [ ./gaming.nix ];

  home.packages = with pkgs; [
    discord
    piper
  ];
}
