_: {
  imports = [ ./pihole.nix ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
