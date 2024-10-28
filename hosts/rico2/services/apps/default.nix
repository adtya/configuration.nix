_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./grafana.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
