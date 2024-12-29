{ lib, ... }: {
  options.nodeconfig = {
    facts = {
      local-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "192.168.1.1";
        description = "Local IP of the node";
      };
    };
  };
}
