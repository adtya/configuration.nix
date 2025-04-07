{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.nodeconfig.users;
in
{
  options.nodeconfig.users = {
    root-password-hash-file = lib.mkOption {
      type = lib.types.path;
      example = "/secrets/password-hash";
      description = "Path to file containing passsword hash for root user";
    };
    primary = {
      id = lib.mkOption {
        type = lib.types.int;
        default = 1000;
        example = 1001;
        description = "user id for the non-root primary user";
      };
      name = lib.mkOption {
        type = lib.types.str;
        example = "john";
        description = "user name for the non-root primarty user";
      };
      password-hash-file = lib.mkOption {
        type = lib.types.path;
        example = "/secrets/password-hash";
        description = "Path to file containing the user's password hash";
      };
      long-name = lib.mkOption {
        type = lib.types.str;
        example = "John Doe";
        description = "Longer version of the user's name";
      };
      shell = lib.mkOption {
        type = lib.types.package;
        default = pkgs.zsh;
        example = pkgs.fish;
        description = "Default shell of the user";
      };
      extra-groups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "wheel" ];
        description = "Extra groups the user should be added to";
      };
      allowed-ssh-keys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        example = [ "ssh-ed25519 blah blah" ];
        description = "List of ssh public keys that can log-in as this user";
      };

    };
  };

  config = {
    users = {
      mutableUsers = false;
      users = {
        root = {
          hashedPasswordFile = cfg.root-password-hash-file;
        };
        "${cfg.primary.name}" = {
          isNormalUser = true;
          uid = cfg.primary.id;
          hashedPasswordFile = cfg.primary.password-hash-file;
          description = cfg.primary.long-name;
          inherit (cfg.primary) shell;
          extraGroups = cfg.primary.extra-groups;
          openssh.authorizedKeys.keys = cfg.primary.allowed-ssh-keys;
        };
      };
    };
  };
}
