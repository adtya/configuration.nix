_: {
  imports = [
    ./gnupg.nix
    ./neovim.nix
    ./nh.nix
  ];

  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    git.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
}
