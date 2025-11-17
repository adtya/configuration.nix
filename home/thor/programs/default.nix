{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./virt-manager.nix
  ];

  home.packages = with pkgs; [
    nvtopPackages.amd
    ollama-rocm
    piper
  ];
}
