{ config, pkgs, ... }: {
  services.caddy.virtualHosts."bazarr.labs.adtya.xyz" = {
    extraConfig = ''
      reverse_proxy 127.0.0.1:${toString config.services.bazarr.listenPort}
      import hetzner
    '';
  };

  services.bazarr = {
    enable = true;
    user = "mediaserver";
    group = "mediaserver";
  };
  systemd.services.bazarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
