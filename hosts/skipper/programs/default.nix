_: {
  imports = [
    ./gnupg.nix
    ./neovim.nix
  ];

  programs = {
    dconf.enable = true;
    fuse.userAllowOther = true;
    git.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];
}
