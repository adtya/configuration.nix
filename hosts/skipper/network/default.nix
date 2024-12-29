{ lib, ... }: {
  imports = [ ../../shared/tailscale.nix ];
  systemd = {
    network = {
      enable = true;
      wait-online = {
        enable = true;
        anyInterface = true;
      };
      networks = {
        "20-virbr" = {
          matchConfig = {
            Name = "virbr*";
            Type = "bridge";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "21-docker" = {
          matchConfig = {
            Name = "docker*";
            Type = "bridge";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "22-veth" = {
          matchConfig = {
            Name = "veth*";
            Type = "ether";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "23-vnet" = {
          matchConfig = {
            Name = "vnet*";
            Type = "ether";
          };
          linkConfig = {
            Unmanaged = true;
          };
        };
        "40-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
          };
          networkConfig = {
            DHCP = "yes";
            Domains = [ "~." ];
          };
          dhcpV4Config = {
            UseDomains = true;
            RouteMetric = 100;
          };
          ipv6AcceptRAConfig = {
            RouteMetric = 100;
          };
        };
        "40-wireless" = {
          enable = true;
          matchConfig = {
            Type = "wlan";
          };
          networkConfig = {
            DHCP = "yes";
            IgnoreCarrierLoss = "3s";
            Domains = [ "~." ];
          };
          dhcpV4Config = {
            UseDomains = true;
            RouteMetric = 600;
          };
          ipv6AcceptRAConfig = {
            RouteMetric = 600;
          };
          linkConfig = {
            RequiredForOnline = "routable";
          };
        };
      };
    };
  };

  services.resolved.enable = true;
  networking = {
    useDHCP = lib.mkDefault false;
    useNetworkd = true;

    firewall = {
      allowedTCPPorts = [
        41414 #Torrent
        53317 #LocalSend
      ];
      allowedUDPPorts = [
        6771 #Torrent
        41414 #Torrent
        53317 #LocalSend
      ];
    };

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = false;
        };
        Settings = {
          AutoConnect = "yes";
        };
      };
    };
  };
}
