{...}: {
  imports = [
    ./caddy.nix
    ./dendrite.nix
    ./frpc.nix
    ./nats.nix
    ./postgresql.nix
    ./ssh.nix
  ];
}
