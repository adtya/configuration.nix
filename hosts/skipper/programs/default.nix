_: {
  imports = [
    ./gnupg.nix
    ./neovim.nix
  ];

  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    git.enable = true;
    nix-ld.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
}
