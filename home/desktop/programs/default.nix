{pkgs, ...}: {
  imports = [
    ./aria2.nix
    ./files.nix
    ./firefox.nix
    ./github-cli.nix
    ./gnupg.nix
    ./kitty.nix
    ./mpv.nix
    ./neovim.nix
    ./tmux.nix
    ./virt-manager.nix
    ./yt-dlp.nix
  ];

  home.packages = with pkgs; [
    _1password-gui
    discord
    evince
    git-crypt
    gnome.eog
    gnome.gnome-system-monitor
    gnome3.gnome-disk-utility
    pavucontrol
    spotify-tui
    wl-clipboard
    xdg-utils
    #    yubioath-flutter
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];
}
