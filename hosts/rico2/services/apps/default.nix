_: {
  imports = [
    ./alertmanager.nix
    ./grafana.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
