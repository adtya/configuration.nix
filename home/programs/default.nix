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
    ./git.nix
    ./gnupg.nix
    ./kitty.nix
    ./mpv.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
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
    doctl
    flyctl
    gh
    hcloud
    impala
    #localsend
    ripgrep
    swayimg
    telegram-desktop
    transmission-remote-gtk
    wl-clipboard
    xdg-utils
    yubioath-flutter
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
