{pkgs, ...}: {
  imports = [
    ./aria2.nix
    ./bat.nix
    ./btop.nix
    ./chrome.nix
    ./direnv.nix
    ./exa.nix
    ./git.nix
    ./files.nix
    ./firefox.nix
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
    agenix
    discord
    evince
    gnome.eog
    gnome.gnome-system-monitor
    gnome3.gnome-disk-utility
    lazydocker
    obsidian
    pavucontrol
    ripgrep
    spotify-tui
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
