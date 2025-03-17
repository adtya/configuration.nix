{ username, ... }:
{
  environment.persistence."/persist/system" = {
    users."${username}" = {
      directories = [
        "Documents"
        "Downloads"
        "Others"
        "Projects"
        "Pictures"
        "Videos"

        ".mozilla"
        ".ssh"
        ".gnupg"

	".local/state"
      ];
    };
  };
}
