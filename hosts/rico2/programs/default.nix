{...}: {
  imports = [
    ./neovim.nix
    ./starship.nix
  ];

  programs = {
    zsh.enable = true;
  };
  environment.pathsToLink = ["/share/zsh"];
}
