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
    ./helix.nix
    ./imv.nix
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
    blueberry
    discord
    doctl
    flyctl
    gh
    git-crypt
    #localsend
    (lutris.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud ]; })
    nixpkgs-review
    nix-init
    nurl
    pavucontrol
    ripgrep
    signal-desktop-beta
    spotify
    (steam.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud ]; })
    (steam.override { extraPkgs = p: [ p.gamemode p.gamescope p.mangohud ]; }).run
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
