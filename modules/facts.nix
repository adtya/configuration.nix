{ lib, ... }: {
  options.nodeconfig = {
    facts = {
      wireguard-ip = lib.mkOption {
        type = lib.types.str;
        default = null;
        example = "10.0.0.1";
        description = "Wireguard IP of the node";
      };
    };
  };
}
