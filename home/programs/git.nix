{
  pkgs,
  secrets,
  ...
}: let
  user = secrets.users;
in {
  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    userEmail =
      if pkgs.stdenv.isLinux
      then user.primary.emailAddress
      else user.primary.workEmail;
    userName = user.primary.realName;
    signing = {
      key = user.primary.pgpFingerprint;
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
    ignores = ["/.nix" "/.direnv"];
  };
}
