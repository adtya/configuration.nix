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
      ".config/obsidian"
      ".fly"
      ".gnupg"
      ".local/share/direnv"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".local/share/nix"
      ".local/share/zoxide"
      ".local/share/zsh"
      ".local/state"
      ".mozilla"
      ".ssh"
      {
        directory = ".config/nvim";
        method = "symlink";
      }
      {
        directory = ".local/share/waydroid";
        method = "symlink";
      }
      {
        directory = ".config/nixos";
        method = "symlink";
      }
      {
        directory = ".local/share/nvim";
        method = "symlink";
      }
      {
        directory = "Documents";
        method = "symlink";
      }
      {
        directory = "Downloads";
        method = "symlink";
      }
      {
        directory = "Music";
        method = "symlink";
      }
      {
        directory = "Others";
        method = "symlink";
      }
      {
        directory = "Pictures";
        method = "symlink";
      }
      {
        directory = "Projects";
        method = "symlink";
      }
      {
        directory = "Public";
        method = "symlink";
      }
      {
        directory = "Templates";
        method = "symlink";
      }
      {
        directory = "Videos";
        method = "symlink";
      }
    ];

    files = [
      ".config/wallpaper_config.json"
      ".docker/config.json"
    ];
  };
}
