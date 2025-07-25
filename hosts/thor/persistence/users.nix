{ primary-user, ... }:
{
  environment.persistence."/persist/state" = {
    users."${primary-user.name}" = {
      directories = [
        "Games"
        ".steam"
        ".local/share/Steam"
        ".local/share/vulkan"
      ];
    };
  };
}
