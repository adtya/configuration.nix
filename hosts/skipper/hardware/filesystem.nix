_: {
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/mnt/system" ];
  };
  disko.devices = {
    disk = {
      main = {
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
            luks0 = {
              size = "100%";
              content = {
                type = "luks";
                name = "CRYPT";
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
  fileSystems."/persist".neededForBoot = true;
}
