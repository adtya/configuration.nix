{secrets, ...}: let
  user = secrets.users;
in {
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        syntax-theme = "Dracula";
      };
    };
    userEmail = user.primary.emailAddress;
    userName = user.primary.realName;
    signing = {
      key = user.primary.pgpFingerprint;
      signByDefault = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
    ignores = ["/.nix" "/.direnv"];
  };
}
