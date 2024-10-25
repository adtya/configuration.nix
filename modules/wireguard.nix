{ lib, config, ... }:
let cfg = config.nodeconfig; in {
  options.nodeconfig = {
    wireguard = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use WireGuard on the node";
      };
      listen-port = lib.mkOption {
        type = lib.types.int;
        default = 51820;
        description = "Listen port used by WireGuard on the the default interface";
      };
      pk-file = lib.mkOption {
        type = lib.types.str;
        default = "/etc/wireguard/private.key";
        description = "Path to the file containing the WireGuard private key";
      };
      endpoint = lib.mkOption {
        type = lib.types.str;
        example = "123.122.121.120:51820";
        description = "IP and port of the default peer";
      };
      endpoint-publickey = lib.mkOption {
        type = lib.types.str;
        description = "Public key of the default peer";
      };
      psk-file = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "";
        example = "/etc/wireguard/preshared.key";
        description = "Path to the file containing the pre-shared key";
      };
      interface-name = lib.mkOption {
        type = lib.types.str;
        default = "wg0";
        description = "Name of the WireGuard interface created";
      };
      allowed-ips = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "10.0.0.0/24" "fd7c::/64" ];
        description = "IP ranges used with WireGuard";
      };
      node-ips = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "10.0.0.1/24" "fd7c::1/64" ];
        description = "WireGuard IPs of this node";
      };
    };
  };

  config = lib.mkIf cfg.wireguard.enable {
    networking.firewall.trustedInterfaces = [ cfg.wireguard.interface-name ];
    networking.wg-quick = {
      interfaces = {
        "${cfg.wireguard.interface-name}" = {
          address = cfg.wireguard.node-ips;
          dns = [ "10.10.10.10" ];
          listenPort = cfg.wireguard.listen-port;
          privateKeyFile = cfg.wireguard.pk-file;
          peers = [
            {
              endpoint = cfg.wireguard.endpoint;
              publicKey = cfg.wireguard.endpoint-publickey;
              presharedKeyFile = cfg.wireguard.psk-file;
              persistentKeepalive = 20;
              allowedIPs = cfg.wireguard.allowed-ips;
            }
          ];
        };
      };
    };
  };
}
