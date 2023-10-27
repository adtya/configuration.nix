{
  secrets,
  if3,
  ...
}: {
  services.caddy = {
    enable = true;
    inherit (secrets.caddy_config) email;

    virtualHosts = {
      "proofs.adtya.xyz" = {
        extraConfig = ''
          redir https://keyoxide.org/hkp/${secrets.users.primary.pgpFingerprint}
        '';
      };

      "if3.adtya.xyz" = {
        extraConfig = ''
          root * ${if3.packages.web}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        '';
      };
    };
  };
}
