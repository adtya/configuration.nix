_: {
  imports = [
    ./services
    ./users.nix
  ];

  boot = {
    initrd = {
      supportedFilesystems = [
        "vfat"
        "btrfs"
      ];
    };
    supportedFilesystems = [
      "vfat"
      "exfat"
      "ext4"
      "btrfs"
    ];
  };

  i18n = {
    defaultCharset = "UTF-8";
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "en_IN/UTF-8" ];
  };

  time.timeZone = "Asia/Kolkata";
}
