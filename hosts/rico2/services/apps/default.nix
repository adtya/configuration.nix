_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./forgejo-actions-runner.nix
    ./grafana.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
