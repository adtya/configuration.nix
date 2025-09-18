_:
let
  domainName = "proofs.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        redir https://keyoxide.org/hkp/51E4F5AB1B82BE45B4229CC243A5E25AA5A27849
      '';
    };
  };
}
