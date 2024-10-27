_: {
  imports = [
    ./adtya.xyz.nix
    ./proofs.nix
    ./wiki.nix
    ./alertmanager.nix
    ./blocky.nix
    ./loki
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
