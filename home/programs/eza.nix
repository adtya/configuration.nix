_: {
  programs.eza = {
    enable = true;
    enableAliases = true;
    extraOptions = ["--group-directories-first" "--group"];
    git = true;
    icons = true;
  };
}
