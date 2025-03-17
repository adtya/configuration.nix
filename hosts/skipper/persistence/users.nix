{ username, ... }:
{
  environment.persistence."/persist/home" = {
    users."${username}" = {
      directories = [
        ".mozilla"
        ".ssh"
        ".gnupg"
        "Documents"
        "Downloads"
        "Others"
        "Projects"
        "Pictures"
        "Videos"
      ];
    };
  };
}
