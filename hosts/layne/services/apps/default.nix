_: {
  imports = [
    ./jellyfin.nix
    ./transmission.nix
    ./radarr.nix
    ./sonarr.nix
    ./jackett.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
