_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./forgejo-actions-runner.nix
    ./grafana.nix
    ./homepage
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
