{ config, ... }:
{
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/mnt/system" "/mnt/data" ];
  };
  disko.devices = {
    disk = {
      "${config.networking.hostName}" = {
        device = "/dev/disk/by-id/nvme-eui.36355a30529803240025384500000001";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            CRYPT = {
              size = "100%";
              content = {
                type = "luks";
                name = "${config.networking.hostName}-ROOT";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
                initrdUnlock = true;
                content = {
                  type = "btrfs";
                  mountpoint = "/mnt/system";
                  mountOptions = [
                    "compress=zstd"
                    "relatime"
                  ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "relatime"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "relatime"
                      ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "relatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };

      };
    };
  };

  environment.etc.crypttab.text = ''
    Thor-DATA UUID=025ac2cc-8dbd-4ae9-8f07-7ac9554ddaf2 /persist/secrets/luks/Thor-DATA.key
  '';

  fileSystems = {
    "/persist".neededForBoot = true;
    "/mnt/data" = {
      device = "/dev/mapper/${config.networking.hostName}-DATA";
      fsType = "btrfs";
      options = [
        "subvol=/"
        "compress=zstd"
        "relatime"
      ];
      neededForBoot = false;
    };
  };
}
