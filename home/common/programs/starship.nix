{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      git_metrics.disabled = false;
    };
  };
}
