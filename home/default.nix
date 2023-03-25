{
  impermanence,
  pkgs,
  ...
}: let
  user = import ../users/user.nix;
in {
  programs.fuse.userAllowOther = true;

  fileSystems."/home/${user.primary.userName}" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = ["mode=0755" "uid=1000" "gid=100"];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.${user.primary.userName} = {pkgs, ...}: {
    imports = [
      impermanence.nixosModules.home-manager.impermanence

      ./dev.nix
      ./downloader.nix
      ./firefox.nix
      ./media.nix
      ./persistence.nix
      ./scripts.nix
      ./sway
      ./terminal.nix
      ./virt-manager.nix
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

    home.packages = with pkgs; [
      _1password-gui
      brightnessctl
      discord
      evince
      gnome.eog
      gnome.gnome-system-monitor
      gnome3.gnome-disk-utility
      libsecret
      pantheon.elementary-files
      pavucontrol
      xdg-utils
      yubioath-flutter
      yubikey-manager
      yubikey-manager-qt
    ];

    dconf.settings = {
      "io/elementary/files/preferences" = {
        "singleclick-select" = true;
      };
      "org/gtk/settings/file-chooser" = {
        "sort-directories-first" = true;
      };
    };

    programs = {
      gpg = {
        enable = true;
        settings = {
          keyserver = "hkps://keys.openpgp.org";
        };
        scdaemonSettings = {
          disable-ccid = true;
        };
      };
      ssh = {
        enable = true;
      };
    };

    services.blueman-applet.enable = true;
    services.gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryFlavor = "tty";
    };

    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs.enable = true;

    xdg.desktopEntries."nixos-manual".name = "NixOS Manual";
    xdg.desktopEntries."nixos-manual".exec = "nixos-help";
    xdg.desktopEntries."nixos-manual".noDisplay = true;

    home.stateVersion = "23.05";
  };
}
