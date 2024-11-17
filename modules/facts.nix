{ lib, ... }: {
  options.nodeconfig = {
    facts = {
      wireguard-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "10.0.0.1";
        description = "Wireguard IP of the node";
      };
      local-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "192.168.1.1";
        description = "Local IP of the node";
      };
      external-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "11.1.1.2";
        description = "Public facing IP of the node";
      };
    };
  };
}
