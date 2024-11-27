_: {
  imports = [
    ./conduwuit.nix
    ./dendrite
    ./forgejo.nix
    ./ntfy.nix
    ./postgresql.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
