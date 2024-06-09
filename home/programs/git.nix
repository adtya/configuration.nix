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
      commit.verbose = true;
      core = {
        fsmonitor = true;
        untrackedCache = true;
      };
      diff.algorithm = "histogram";
      feature.manyFiles = true;
      fetch.prune = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      pull.ff = "only";
    };
    ignores = [ "/.nix" "/.direnv" ];
  };
}
