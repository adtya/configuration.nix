{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./users
    ./home
    ./programs
    ./services
  ];

  fonts.packages = with pkgs; [
      nerd-fonts.fira-code
  ];

  system.stateVersion = 5;
}
