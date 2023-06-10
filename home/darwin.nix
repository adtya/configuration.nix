{user, ...}: {
  home = {
    username = user.primary.userName;
    homeDirectory = "/Users/${user.primary.userName}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;

  imports = [./programs/neovim.nix];
}
