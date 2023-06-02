{...}: let
  user = (import ../../secrets.nix).users;
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
    };
    ignores = ["/.nix" "/.direnv"];
  };
}
