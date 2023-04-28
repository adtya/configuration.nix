{ ... }: {
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".cache/aria2"
      ".cache/mesa_shader_cache"
      ".cache/mozilla"
      ".cache/nix"
      ".config/1Password"
      ".config/dconf"
      ".config/discord"
      ".config/lazygit"
      ".config/spotify-tui"
      ".gnupg"
      ".local/share/keyrings"
      ".local/share/nix"
      ".local/share/zoxide"
      ".local/share/zsh"
      ".local/state"
      ".mozilla"
      ".nixos-config"
      ".ssh"
      { directory = "Documents"; method = "symlink"; }
      { directory = "Downloads"; method = "symlink"; }
      { directory = "Music"; method = "symlink"; }
      { directory = "Others"; method = "symlink"; }
      { directory = "Pictures"; method = "symlink"; }
      { directory = "Projects"; method = "symlink"; }
      { directory = "Public"; method = "symlink"; }
      { directory = "Templates"; method = "symlink"; }
      { directory = "Videos"; method = "symlink"; }
    ];

    files = [
      ".config/gh/hosts.yml"
    ];
  };
}
