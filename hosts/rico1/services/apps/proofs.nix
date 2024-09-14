_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "proofs.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts = {
      "${domainName}" = {
        logFormat = logFormat domainName;
        extraConfig = ''
          redir https://keyoxide.org/hkp/51E4F5AB1B82BE45B4229CC243A5E25AA5A27849
        '';
      };
    };

    frp.settings.proxies = [
      {
        name = "http.${domainName}";
        type = "http";
        customDomains = [ "${domainName}" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.${domainName}";
        type = "https";
        customDomains = [ "${domainName}" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
