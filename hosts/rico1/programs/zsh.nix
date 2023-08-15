_: {
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
  environment.pathsToLink = ["/share/zsh"];
}
