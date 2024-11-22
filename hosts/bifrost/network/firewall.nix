_: {
  systemd.services.nftables.after = [ "wg-quick-Homelab.service" ];
  networking = {
    nftables = {
      enable = true;
      ruleset = ''
        table ip nat {
          chain PREROUTING {
            type nat hook prerouting priority dstnat;
            iifname ens3 tcp dport 22 dnat to 10.10.10.13:2222
          }
          chain POSTROUTING {
            type nat hook postrouting priority srcnat;
            ip daddr 10.10.10.13 masquerade
          };
        }
      '';
    };
  };
}
