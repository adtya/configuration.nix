{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-credential-helpers ];
  virtualisation = {
    docker = {
      enable = true;
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
