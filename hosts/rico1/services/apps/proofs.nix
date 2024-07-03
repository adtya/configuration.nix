_: {
  services = {
    caddy.virtualHosts = {
      "proofs.adtya.xyz" = {
        extraConfig = ''
          redir https://keyoxide.org/hkp/51E4F5AB1B82BE45B4229CC243A5E25AA5A27849
        '';
      };
    };

    frp.settings.proxies = [
      {
        name = "http.proofs.adtya.xyz";
        type = "http";
        customDomains = [ "proofs.adtya.xyz" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.proofs.adtya.xyz";
        type = "https";
        customDomains = [ "proofs.adtya.xyz" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
