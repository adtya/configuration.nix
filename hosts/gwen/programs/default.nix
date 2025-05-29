_: {
  imports = [
    ./neovim.nix
    ./nh.nix
  ];
  programs = {
    dconf.enable = true;
    git.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
}
