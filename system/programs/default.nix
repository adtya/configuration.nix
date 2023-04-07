{ ... }: {

  imports = [
    ./gnupg.nix
    ./neovim.nix
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
    seahorse.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];
}
