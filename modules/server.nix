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
  config = lib.mkIf cfg.is-server {
    boot.kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    networking.firewall = {
      allowPing = true;
      logRefusedConnections = lib.mkDefault false;
    };
    systemd = {
      services = {
        NetworkManager-wait-online.enable = false;
        systemd-networkd.stopIfChanged = false;
        systemd-resolved.stopIfChanged = false;
      };
      enableEmergencyMode = false;
      watchdog = {
        runtimeTime = "15s";
        rebootTime = "30s";
        kexecTime = "1m";
      };
      sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
      '';
    };
  };
}
