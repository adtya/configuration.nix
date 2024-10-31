_: {
  imports = [
    ./alertmanager.nix
    ./blocky.nix
    ./forgejo-actions-runner.nix
    ./grafana.nix
    ./homer
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
