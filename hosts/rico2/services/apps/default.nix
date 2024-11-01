_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./forgejo-actions-runner.nix
    ./grafana.nix
    ./homepage.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
