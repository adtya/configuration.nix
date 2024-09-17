_: {
  imports = [
    ./dendrite
    ./acomputer.lol.nix
    ./ntfy.nix
    ./postgresql.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
