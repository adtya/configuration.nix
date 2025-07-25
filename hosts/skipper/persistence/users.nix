{ primary-user, ... }:
{
  environment.persistence."/persist/state" = {
    users."${primary-user.name}" = {
      directories = [
        ".config/transmission-daemon"
        ".config/transmission-remote-gtk"
      ];
    };
  };
}
