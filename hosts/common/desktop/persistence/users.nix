{ primary-user, ... }:
{
  environment.persistence."/persist/state" = {
    users."${primary-user.name}" = {
      directories = [
        "Documents"
        "Downloads"
        "Others"
        "Projects"
        "Pictures"
        "Videos"

        ".fly"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        ".mozilla"
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".var"

        ".config/1Password"
        ".config/dconf"
        ".config/discord"
        ".config/doctl"
        ".config/gh"
        ".config/hcloud"
        ".config/lazygit"
        ".config/nvim"
        ".config/spotify"

        {
          directory = ".local/share/containers";
          mode = "0700";
        }
        ".local/share/dino"
        ".local/share/direnv"
        ".local/share/flatpak"
        ".local/share/keyrings"
        ".local/share/nvim"
        ".local/share/nix"
        ".local/share/systemd"
        ".local/share/TelegramDesktop"
        ".local/share/zsh"
        ".local/share/zoxide"

        ".local/state"
      ];
      files = [
        ".config/wallpaper_config.json"
        {
          file = ".config/sops/age/keys.txt";
          parentDirectory.mode = "0700";
        }
      ];
    };
  };
}
