_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./grafana.nix
    ./prometheus.nix
    ../../../shared/prometheus-exporters.nix
  ];
}
