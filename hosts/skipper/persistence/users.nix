{ username, ... }:
{
  environment.persistence."/persist/system" = {
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
