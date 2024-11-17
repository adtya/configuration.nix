_: {
  networking = {
    firewall.allowedTCPPorts = [ 42069 ];
    nftables = {
      enable = true;
      ruleset = ''
        table ip nat {
          chain PREROUTING {
            type nat hook prerouting priority -100 ;
            iifname ens3 tcp dport 42069 dnat to 10.10.10.13
          }
          chain POSTROUTING {
            type nat hook postrouting priority 100 ;
            ip daddr 10.10.10.13 masquerade
          };
        }
      '';
    };
  };
}
