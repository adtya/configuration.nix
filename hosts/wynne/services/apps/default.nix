_: {
  imports = [
    ./conduwuit.nix
    ./forgejo.nix
    ./ntfy.nix
    ./postgresql.nix
    ./vaultwarden.nix
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
}
