{ ... }: {
  imports = [
    ./btrfs.nix
    ./caddy.nix
    ./dendrite
    ./frpc.nix
    ./nats.nix
    ./postgresql.nix
    ./ssh.nix
  ];
}
