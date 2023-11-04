{ config
, secrets
, ...
}: {
  services = {
    caddy.virtualHosts = {
      "proofs.adtya.xyz" = {
        extraConfig = ''
          redir https://keyoxide.org/hkp/${secrets.users.primary.pgpFingerprint}
        '';
      };
    };

    frp.settings = {
      "http.proofs.adtya.xyz" = {
        type = "http";
        custom_domains = "proofs.adtya.xyz";
        local_port = 80;
      };

      "https.proofs.adtya.xyz" = {
        type = "https";
        custom_domains = "proofs.adtya.xyz";
        local_port = 443;
      };
    };
  };
}
