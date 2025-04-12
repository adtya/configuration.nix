{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nodeconfig.sudo;
in
{
  options = {
    nodeconfig.sudo = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = "Enable sudo (and polkit)";
      };
      primary-user-is-wheel = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = "Add the primary (non root) user to @wheel";
      };
      wheel-is-god = lib.mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
        description = "Let @wheel do stuff without password";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        security = {
          polkit = {
            enable = true;
            adminIdentities = [ "unix-group:wheel" ];
          };
          sudo = {
            enable = true;
            package = pkgs.sudo.override { withInsults = true; };
            extraConfig = ''
              Defaults lecture="never"
            '';
            wheelNeedsPassword = !cfg.wheel-is-god;
          };

        };
      }
      (lib.mkIf cfg.primary-user-is-wheel { nodeconfig.users.primary.extra-groups = [ "wheel" ]; })
    ]
  );
}
