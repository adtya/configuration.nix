{ config, pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-credential-helpers ];
  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.docker_26;
      daemon.settings = {
        data-root = "/persist/docker";
        dns = [
          # Quad9, without DoT
          "2620:fe::fe"
          "9.9.9.9"
          "2620:fe::9"
          "149.112.112.112"
        ];
      };
      rootless = {
        enable = true;
        package = config.virtualisation.docker.package;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "/persist/home/docker";
          dns = config.virtualisation.docker.daemon.settings.dns;
        };
      };
      storageDriver = "btrfs";
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };
}
