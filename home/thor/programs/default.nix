{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./virt-manager.nix
  ];

  home.packages = with pkgs; [
    ollama-rocm
    piper
  ];
}
