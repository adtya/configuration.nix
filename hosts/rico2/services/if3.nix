{
  config,
  if3,
  ...
}: {
  services.caddy.virtualHosts = {
    "if3.adtya.xyz" = {
      extraConfig = ''
        root * ${if3.packages.${config.nixpkgs.system}.default}/share/web
        encode gzip
        try_files {path} /index.html
        file_server
      '';
    };
  };
}
