{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nodeconfig;
in
{
  options.nodeconfig = {
    is-pi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Is the node a Raspberry Pi?";
    };
  };

  config = lib.mkIf cfg.is-pi { };
}
