{ pkgs, ... }:
{
  virtualisation = {
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
  nodeconfig.users.primary.extra-groups = [ "libvirtd" ];

  systemd.network.networks = {
    "20-virbr" = {
      matchConfig = {
        Name = "virbr*";
        Type = "bridge";
      };
      linkConfig = {
        Unmanaged = true;
      };
    };
    "22-veth" = {
      matchConfig = {
        Name = "veth*";
        Type = "ether";
      };
      linkConfig = {
        Unmanaged = true;
      };
    };
    "23-vnet" = {
      matchConfig = {
        Name = "vnet*";
        Type = "ether";
      };
      linkConfig = {
        Unmanaged = true;
      };
    };
  };
}
