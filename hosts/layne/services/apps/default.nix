_: {
  imports = [
    ./jellyfin.nix
    ./transmission.nix
    ./radarr.nix
    ./sonarr.nix
    ./readarr.nix
    ./prowlarr.nix
    ./bazarr.nix
    ./lidarr.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
