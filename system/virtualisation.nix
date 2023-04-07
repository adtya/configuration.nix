{ pkgs, ... }: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    kvmgt.enable = true;
    libvirtd = {
      enable = true;
      qemu.ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
    lxc = {
      enable = true;
      lxcfs.enable = true;
    };
    lxd.enable = true;
  };
}
