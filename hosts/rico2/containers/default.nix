{ ... }: {
  imports = [ ];

  virtualisation.oci-containers = {
    backend = "podman";
  };
}
