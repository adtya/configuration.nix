_: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      git_metrics.disabled = false;
      nix_shell.disabled = true;
      direnv.disabled = false;
    };
  };
}
