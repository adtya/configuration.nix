{ pkgs, ... }: {
  imports = [
    ./dev.nix
    ./downloader.nix
    ./firefox.nix
    ./kitty.nix
    ./nixvim.nix
    ./tmux.nix
    ./tui.nix
    ./virt-manager.nix
  ];

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
    yubikey-personalization
    yubikey-personalization-gui
  ];

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

}
