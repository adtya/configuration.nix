{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./exa.nix
    ./git.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    lazydocker
    ripgrep
  ];

  programs = {
    fzf.enable = true;
    lazygit.enable = true;
    ssh.enable = true;
    zoxide.enable = true;
  };
}
