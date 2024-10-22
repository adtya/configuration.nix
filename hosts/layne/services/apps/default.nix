_: {
  imports = [
    ./jellyfin.nix
    ./transmission.nix
    ./radarr.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
