{...}: {
  imports = [
    ./caddy.nix
    ./frpc.nix
    ./nats.nix
    ./postgresql.nix
    ./ssh.nix
  ];
}
