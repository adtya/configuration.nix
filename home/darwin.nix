{user, ...}: {
  home = {
    username = user.primary.userName;
    homeDirectory = "/Users/${user.primary.userName}";
    stateVersion = "23.11";
  };
  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    nix-index.enable = true;
    zoxide.enable = true;
  };

  imports = [./programs/neovim.nix ./programs/zsh.nix ./programs/tmux.nix ./programs/starship.nix ./programs/exa.nix ./programs/direnv.nix ./programs/bat.nix ./programs/git.nix];
}
