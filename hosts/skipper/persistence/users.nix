{ primary-user, ... }:
{
  environment.persistence."/persist/state" = {
    users."${primary-user.name}" = {
      directories = [
        "Documents"
        "Downloads"
        "Games"
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
        ".steam"
        ".var"

        ".config/1Password"
        ".config/dconf"
        ".config/discord"
        ".config/doctl"
        ".config/gh"
        ".config/hcloud"
        ".config/lazygit"
        ".config/nvim"
        ".config/transmission-daemon"
        ".config/transmission-remote-gtk"

        {
          directory = ".local/share/containers";
          mode = "0700";
        }
        ".local/share/direnv"
        ".local/share/flatpak"
        ".local/share/icons/hicolor"
        ".local/share/keyrings"
        ".local/share/lutris"
        ".local/share/nvim"
        ".local/share/nix"
        ".local/share/Steam"
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
          parentDirectory = {
            mode = "0700";
          };
        }
      ];
    };
  };
}
