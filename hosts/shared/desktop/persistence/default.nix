{ config, ... }:
{
  imports = [
    ./system.nix
    ./users.nix
  ];

  boot.initrd.systemd.services.rollback = {
    description = "Rollback root subvolume to blank state";
    wantedBy = [ "initrd.target" ];
    after = [ "dev-mapper-${config.networking.hostName}\\x2dROOT.device" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt
      mount -o subvol=/ /dev/mapper/${config.networking.hostName}-ROOT /mnt

      btrfs subvolume list -o /mnt/@root | cut -f9 -d' ' | while read subvolume; do
        echo "deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
      echo "deleting /root subvolume..." &&
      btrfs subvolume delete "/mnt/@root"

      echo "creating blank /root subvolume..."
      btrfs subvolume create "/mnt/@root"

      umount /mnt
    '';
  };
}
