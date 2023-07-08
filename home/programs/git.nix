{secrets, ...}: let
  user = secrets.users;
in {
  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    userEmail = user.primary.emailAddress;
    userName = user.primary.realName;
    signing = {
      key = user.primary.pgpFingerprint;
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rabase = true;
    };
    ignores = ["/.nix" "/.direnv"];
  };
}
