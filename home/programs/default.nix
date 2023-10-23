{pkgs, ...}: {
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
    ./starship.nix
    ./tmux.nix
    ./virt-manager.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-gui
    bitwarden
    discord
    doctl
    evince
    flyctl
    git-crypt
    gnome.eog
    gnome.gnome-system-monitor
    gnome3.gnome-disk-utility
    lazydocker
    obsidian
    pavucontrol
    ripgrep
    spotify-tui
    steam-run
    telegram-desktop
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
    ssh.enable = true;
    zoxide.enable = true;
  };
}
