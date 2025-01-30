{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    doctl
    gh
    hcloud
    ripgrep
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
