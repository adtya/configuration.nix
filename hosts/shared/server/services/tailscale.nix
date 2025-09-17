_: {
  services.tailscale = {
    extraSetFlags = [ "--ssh" ];
    extraUpFlags = [ "--ssh" ];
  };
}
