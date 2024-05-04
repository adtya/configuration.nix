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
    ./gnupg.nix
    ./helix.nix
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

  home.packages = with pkgs; let steam-custom = (steam.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud ]; }); in [
    _1password-gui
    discord
    doctl
    evince
    flyctl
    gh
    git-crypt
    gnome-secrets
    #localsend
    loupe
    (lutris.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud ]; })
    nixpkgs-review
    nix-init
    nurl
    pavucontrol
    ripgrep
    signal-desktop-beta
    spotify
    steam-custom
    steam-custom.run
    telegram-desktop
    transmission-remote-gtk
    wl-clipboard
    xdg-utils
    yubioath-flutter
  ];

  programs = {
    fzf.enable = true;
    lazygit.enable = true;
    nix-index.enable = true;
    zoxide.enable = true;
  };
}
