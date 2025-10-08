_: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 14;
      font-family = "Fira Code";
      font-synthetic-style = false;
      adjust-icon-height = "-16.6%";
      theme = "Dracula";
      mouse-hide-while-typing = true;
      background-opacity = "0.98";
      background-blur = true;
      window-padding-x = 4;
      window-padding-balance = true;
      shell-integration = "zsh";
      shell-integration-features = "cursor,sudo,title,ssh-env,no-ssh-terminfo";
    };
  };
}
