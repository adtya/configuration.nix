_: {
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".cache/aria2"
      ".cache/nix-index"
      ".cache/ytfzf"
      ".config/1Password"
      ".config/dconf"
      ".config/doctl"
      ".config/lazygit"
      ".config/gh"
      ".fly"
      ".gnupg"
      ".local/share/direnv"
      ".local/share/keyrings"
      ".local/share/nix"
      ".local/share/Steam"
      ".local/share/zoxide"
      ".local/share/zsh"
      ".local/state"
      ".mozilla"
      ".ssh"
      ".steam"
      "Documents"
      "Downloads"
      "Music"
      "Others"
      "Pictures"
      "Videos"
      { directory = ".config/nvim"; method = "symlink"; }
      { directory = ".config/nixos"; method = "symlink"; }
      { directory = ".local/share/nvim"; method = "symlink"; }
      { directory = "Projects"; method = "symlink"; }
    ];

    files = [
      ".config/wallpaper_config.json"
      ".docker/config.json"
    ];
  };
}
