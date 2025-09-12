{ pkgs, ... }:
{
  imports = [ ./gaming.nix ];

  home.packages = [ pkgs.piper ];
}
