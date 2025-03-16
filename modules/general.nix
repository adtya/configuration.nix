{ lib, config, ... }:
let
  cfg = config.nodeconfig;
in
{
  options.nodeconfig = {
    minimize = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Disable non-essential stuff";
    };
  };

  config = lib.mkIf cfg.minimize {
    documentation = {
      enable = lib.mkDefault false;
      doc.enable = lib.mkDefault false;
      info.enable = lib.mkDefault false;
      man.enable = lib.mkDefault false;
      nixos.enable = lib.mkDefault false;
    };

    fonts.fontconfig.enable = lib.mkDefault false;
    programs.command-not-found.enable = lib.mkDefault false;

    xdg = {
      autostart.enable = lib.mkDefault false;
      icons.enable = lib.mkDefault false;
      mime.enable = lib.mkDefault false;
      sounds.enable = lib.mkDefault false;
      menus.enable = lib.mkDefault false;
    };
  };
}
