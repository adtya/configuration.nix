{ pkgs, ... }: {
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
    ./virt-manager.nix
    ./yt-dlp.nix
    ./zathura.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password-gui
    android-file-transfer
    bitwarden-desktop
    blueberry
    discord
    doctl
    flyctl
    fractal
    gh
    hcloud
    #localsend
    (lutris.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud p.vulkan-tools ]; })
    ripgrep
    signal-desktop
    spotify
    (steam.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud p.vulkan-tools ]; })
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
