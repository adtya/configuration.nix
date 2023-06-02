{...}: let
  secrets = import ../../../secrets.nix;
in {
  services.caddy = {
    enable = true;
    email = secrets.caddy_config.email;

    virtualHosts."proofs.adtya.xyz" = {
      extraConfig = ''
        redir https://keyoxide.org/hkp/${secrets.users.primary.pgpFingerprint}
      '';
    };
  };
}
