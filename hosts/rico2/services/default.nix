{...}: {
  imports = [./caddy.nix ./frpc.nix];
  services.openssh.enable = true;
}
