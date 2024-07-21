_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./grafana.nix
    ./loki.nix
    ./prometheus.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
