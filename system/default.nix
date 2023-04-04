{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./gtk.nix
    ./hardware.nix
    ./packages.nix
    ./persistence.nix
    ./plymouth.nix
    ./secureboot.nix
    ./services.nix
    ./virtualisation.nix
  ];

  boot = {
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.swappiness" = 0;
    };
  };

  console.useXkbConfig = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

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

  networking = {
    hostName = "Skipper";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
      extraConfig = ''
        [device]
        wifi.iwd.autoconnect=yes
      '';
    };
    useDHCP = lib.mkDefault false;
    wireless.iwd.enable = true;
  };

  security = {
    apparmor = {
      enable = true;
      enableCache = true;
    };
    audit.enable = true;
    auditd.enable = true;
    pam.u2f = {
      enable = true;
      authFile = "/etc/u2f_keys";
      cue = true;
    };
    polkit.enable = true;
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      abrmd.enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    sudo = {
      package = pkgs.sudo.override { withInsults = true; };
      extraConfig = ''
        Defaults lecture="never"

        %wheel ALL=NOPASSWD: ${config.boot.kernelPackages.cpupower}/bin/cpupower
      '';
      wheelNeedsPassword = true;
    };
  };

  sound.enable = true;

  time.timeZone = "Asia/Kolkata";

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  system.stateVersion = "23.05";
}
