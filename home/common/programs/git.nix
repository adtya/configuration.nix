{ primary-user, ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = false;
      syntax-theme = "Dracula";
    };
  };

  programs.git = {
    enable = true;
    signing = {
      key = "51E4F5AB1B82BE45B4229CC243A5E25AA5A27849";
      signByDefault = true;
    };
    settings = {
      user.email = primary-user.email;
      user.name = primary-user.long-name;
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
    ignores = [
      "/.nix"
      "/.direnv"
    ];
  };
}
