{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./virt-manager.nix
  ];

  home.packages = [ pkgs.piper ];

  programs.btop.package = pkgs.btop-rocm.overrideAttrs (_oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "aristocratos";
      repo = "btop";
      rev = "4f5abbb3ebf6c5520ed33cf9f81bed405b6a0b4b";
      hash = "sha256-ih66RmZtui53DgFmiKcy08ibs0KXRCKFURD8Kh3oYlo=";
    };
  });
}
