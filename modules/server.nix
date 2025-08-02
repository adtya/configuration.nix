{ lib, config, ... }:
let
  cfg = config.nodeconfig;
in
{
  options.nodeconfig = {
    is-server = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "configure node as a server";
    };
  };
  config = lib.mkIf cfg.is-server { };
}
