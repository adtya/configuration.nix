{ secrets, ... }:
let
  user = secrets.users;
in
{
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = false;
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
      core = {
        fsmonitor = true;
        untrackedCache = true;
      };
      feature.manyFiles = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
    ignores = [ "/.nix" "/.direnv" ];
  };
}
