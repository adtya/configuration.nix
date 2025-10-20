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
    ./ghostty.nix
    ./git.nix
    ./gnupg.nix
    ./imv.nix
    ./mpv.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    android-file-transfer
    devenv
    doctl
    flyctl
    gh
    gnome-disk-utility
    hcloud
    impala
    localsend
    ripgrep
    seahorse
    spotify
    transmission_4-gtk
    wl-clipboard
    xdg-utils
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = false;
    };
    lazygit.enable = true;
    zoxide.enable = true;
  };
}
