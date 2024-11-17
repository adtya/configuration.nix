_: {
  imports = [
    ./alertmanager.nix
    ./forgejo-actions-runner.nix
    ./grafana.nix
    ./homepage.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
