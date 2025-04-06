{ pkgs, treefmt-nix }:
let
  treeFmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
in
treeFmtEval.config.build.wrapper
