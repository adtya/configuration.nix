{...}: {
  virtualisation.oci-containers.containers."adtya.xyz" = {
    image = "ghcr.io/adtya/adtya.xyz:latest";
    ports = ["3000:80"];
  };

  services.caddy.virtualHosts."adtya.xyz" = {
    hostName = "adtya.xyz";
    serverAliases = ["www.adtya.xyz"];
    extraConfig = ''
      reverse_proxy http://127.0.0.1:3000
    '';
  };
}
