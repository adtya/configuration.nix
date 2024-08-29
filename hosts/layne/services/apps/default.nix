_: {
  imports = [
    ./jellyfin.nix
    ./transmission.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
