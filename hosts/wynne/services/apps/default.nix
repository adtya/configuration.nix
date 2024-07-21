_: {
  imports = [
    ./dendrite
    ./acomputer.lol.nix
    ./postgresql.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
