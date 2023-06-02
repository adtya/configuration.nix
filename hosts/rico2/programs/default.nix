{...}: {
  imports = [
    ./neovim.nix
    ./starship.nix
    ./zsh.nix
  ];

  programs.git.enable = true;
}
