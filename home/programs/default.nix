{ pkgs, ... }:
{
  imports = [
    ./firefox

    ./aria2.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./files.nix
    ./gaming.nix
    ./git.nix
    ./gnupg.nix
    ./kitty.nix
    ./mpv.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./virt-manager.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    android-file-transfer
    blueberry
    devenv
    dino
    discord
    doctl
    flyctl
    gh
    gnome-software
    hcloud
    impala
    localsend
    ripgrep
    seahorse
    spotify
    telegram-desktop
    transmission-remote-gtk
    wl-clipboard
    xdg-utils
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = false;
    };
    lazygit.enable = true;
    swayimg.enable = true;
    zoxide.enable = true;
  };
}
