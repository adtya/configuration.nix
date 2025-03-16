_: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--group"
    ];
    git = true;
    icons = "auto";
  };
}
