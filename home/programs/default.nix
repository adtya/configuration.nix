{ pkgs, ... }: {
  imports = [
    ./aria2.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./files.nix
    ./firefox.nix
    ./git.nix
    ./github-cli.nix
    ./gnupg.nix
    ./kitty.nix
    ./mpv.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./virt-manager.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-gui
    discord
    distrobox
    doctl
    evince
    flyctl
    git-crypt
    gnome.eog
    gnome.gnome-system-monitor
    gnome3.gnome-disk-utility
    keepassxc
    lutris
    pavucontrol
    ripgrep
    spotify-player
    steam-run
    telegram-desktop
    winetricks
    (wineWowPackages.waylandFull.override { wineRelease = "staging"; mingwSupport = true; })
    wl-clipboard
    xdg-utils
    yubioath-flutter
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];

  programs = {
    fzf.enable = true;
    lazygit.enable = true;
    nix-index.enable = true;
    zoxide.enable = true;
  };
}
