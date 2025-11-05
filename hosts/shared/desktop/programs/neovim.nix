{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly.packages.${system}.default;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
