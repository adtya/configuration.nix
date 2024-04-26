_: {
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".mozilla"
      ".ssh"
      ".config/dconf"
      ".gnupg"
      ".local/state"
      { directory = ".cache/aria2"; method = "symlink"; }
      { directory = ".cache/nix-index"; method = "symlink"; }
      { directory = ".cache/ytfzf"; method = "symlink"; }
      { directory = ".config/1Password"; method = "symlink"; }
      { directory = ".config/discord"; method = "symlink"; }
      { directory = ".config/doctl"; method = "symlink"; }
      { directory = ".config/gh"; method = "symlink"; }
      { directory = ".config/lazygit"; method = "symlink"; }
      { directory = ".config/nixos"; method = "symlink"; }
      { directory = ".config/nvim"; method = "symlink"; }
      { directory = ".config/Signal Beta"; method = "symlink"; }
      { directory = ".config/spotify"; method = "symlink"; }
      { directory = ".config/transmission-daemon"; method = "symlink"; }
      { directory = ".config/transmission-remote-gtk"; method = "symlink"; }
      { directory = ".fly"; method = "symlink"; }
      { directory = ".local/share/direnv"; method = "symlink"; }
      { directory = ".local/share/icons/hicolor"; method = "symlink"; }
      { directory = ".local/share/keyrings"; method = "symlink"; }
      { directory = ".local/share/lutris"; method = "symlink"; }
      { directory = ".local/share/nix"; method = "symlink"; }
      { directory = ".local/share/nvim"; method = "symlink"; }
      { directory = ".local/share/Steam"; method = "symlink"; }
      { directory = ".local/share/TelegramDesktop"; method = "symlink"; }
      { directory = ".local/share/zoxide"; method = "symlink"; }
      { directory = ".local/share/zsh"; method = "symlink"; }
      { directory = ".steam"; method = "symlink"; }
      { directory = "Documents"; method = "symlink"; }
      { directory = "Downloads"; method = "symlink"; }
      { directory = "Music"; method = "symlink"; }
      { directory = "Others"; method = "symlink"; }
      { directory = "Pictures"; method = "symlink"; }
      { directory = "Videos"; method = "symlink"; }
      { directory = "Projects"; method = "symlink"; }
    ];

    files = [
      ".config/wallpaper_config.json"
      ".docker/config.json"
    ];
  };
}
