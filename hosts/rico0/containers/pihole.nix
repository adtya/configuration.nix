_: {
  services.caddy.virtualHosts."http://pihole.local.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:3000
      '';
    };
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "pihole/pihole:latest";
      hostname = "heimdall";
      environmentFiles = [
        "/var/lib/pihole/.env"
      ];
      volumes = [
        "/var/lib/pihole/etc/pihole:/etc/pihole/"
        "/var/lib/pihole/etc/dnsmasq.d:/etc/dnsmasq.d/"
      ];
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "67:67/udp"
        "3000:80/tcp"
      ];
    };
  };
}
