{ ... }: {
  imports = [
    ./caddy.nix
    ./dendrite
    ./frpc.nix
    ./nats.nix
    ./postgresql.nix
    ./ssh.nix
  ];
}
