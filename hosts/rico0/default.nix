{ ... }: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./containers
    ./network.nix
    ./security.nix
  ];

nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  time.timeZone = "Asia/Kolkata";
  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    stateVersion = "23.11";
  };
}
