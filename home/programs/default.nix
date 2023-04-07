{ pkgs, ... }: {
  imports = [
    ./aria2.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./exa.nix
    ./firefox.nix
    ./git.nix
    ./github-cli.nix
    ./gnupg.nix
    ./kitty.nix
    ./mpv.nix
    ./nixvim.nix
    ./starship.nix
    ./tmux.nix
    ./virt-manager.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-gui
    celluloid
    discord
    evince
    git-crypt
    gnome.eog
    gnome.gnome-system-monitor
    gnome3.gnome-disk-utility
    lazydocker
    pantheon.elementary-files
    pavucontrol
    ripgrep
    spotify-tui
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
    ssh.enable = true;
    zoxide.enable = true;
  };
}
