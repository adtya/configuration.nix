_: {
  services = {
    caddy.virtualHosts."readarr.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:8787
        import hetzner
      '';
    };
    readarr = {
      enable = true;
      dataDir = "/mnt/data/readarr";
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.readarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
