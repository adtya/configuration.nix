_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./grafana.nix
    ./prometheus.nix
    ./loki
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
