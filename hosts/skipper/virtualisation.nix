{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-credential-helpers ];
  virtualisation = {
    docker = {
      enable = false;
      package = pkgs.docker_26;
      daemon.settings = {
        data-root = "/persist/docker";
      };
      rootless = {
        enable = true;
        package = pkgs.docker_26;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "/persist/home/docker";
        };
      };
      storageDriver = "btrfs";
    };
    kvmgt.enable = true;
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
