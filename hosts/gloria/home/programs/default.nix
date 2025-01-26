_: {
  imports = [
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
    ./zsh.nix
  ];
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = false;
    };
    lazygit.enable = true;
    zoxide.enable = true;
  };
}
