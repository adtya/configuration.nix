{ pkgs, lib, ... }: {
  imports = [
    ./neovim.nix
    ./starship.nix
    ./zsh.nix
  ];

  programs = {
    command-not-found.enable = lib.mkDefault false;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
