{ ... }: {
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".cache/mesa_shader_cache"
      ".cache/mozilla"
      ".cache/nix"
      ".config/1Password"
      ".config/dconf"
      ".config/lazygit"
      ".config/spotify-tui"
      ".gnupg"
      ".local/share/atuin"
      ".local/share/flatpak"
      ".local/share/keyrings"
      ".local/share/nix"
      ".local/share/zsh"
      ".mozilla"
      ".nixos-config"
      ".ssh"
      ".var"

      "Documents"
      "Downloads"
      "Music"
      "Others"
      "Pictures"
      "Projects"
      "Videos"
    ];

    files = [
      ".config/gh/hosts.yml"
    ];
  };
}
