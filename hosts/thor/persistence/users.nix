{ primary-user, ... }:
{
  environment.persistence."/persist/state" = {
    users."${primary-user.name}" = {
      directories = [
        "Games"
        ".ollama"
        ".steam"
        ".local/share/icons/hicolor"
        ".local/share/lutris"
        ".local/share/Steam"
        ".local/share/vulkan"
      ];
    };
  };
}
