{ lib, ... }: {
  options.nodeconfig = {
    facts = {
      tailnet-name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "tailabcdef.ts.net";
        description = "Tailnet Name";
      };
      tailscale-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "192.168.1.1";
        description = "Tailscale IP of the node";
      };
      local-ip = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "192.168.1.1";
        description = "Local IP of the node";
      };
    };
  };
}
