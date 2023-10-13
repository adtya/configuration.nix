_: {
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".cache/aria2"
      ".cache/mozilla"
      ".cache/nix-index"
      ".cache/ytfzf"
      ".config/1Password"
      ".config/dconf"
      ".config/doctl"
      ".config/lazygit"
      ".config/obsidian"
      ".config/spotify-tui"
      ".fly"
      ".gnupg"
      ".local/share/keyrings"
      ".local/share/nix"
      ".local/share/zoxide"
      ".local/share/zsh"
      ".local/state"
      ".mozilla"
      ".ssh"
      {
        directory = ".nixos-config";
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
      ".config/gh/hosts.yml"
      ".config/wallpaper_config"
    ];
  };
}
