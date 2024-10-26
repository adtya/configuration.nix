_: {
  imports = [
    ./jellyfin.nix
    ./transmission.nix
    ./radarr.nix
    ./sonarr.nix
    ./readarr.nix
    ./jackett.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
