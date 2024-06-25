{ pkgs, ... }: {
  imports = [
    ./neovim.nix
    ./starship.nix
    ./zsh.nix
  ];

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    sops
    age
    libraspberrypi
    raspberrypi-eeprom
  ];

}
