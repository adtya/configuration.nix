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
    lxc.enable = true;
    waydroid.enable = true;
  };
}
