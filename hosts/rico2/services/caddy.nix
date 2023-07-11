{secrets, ...}: {
  services.caddy = {
    enable = true;
    inherit (secrets.caddy_config) email;

    virtualHosts."proofs.adtya.xyz" = {
      extraConfig = ''
        redir https://keyoxide.org/hkp/${secrets.users.primary.pgpFingerprint}
      '';
    };
  };
}
