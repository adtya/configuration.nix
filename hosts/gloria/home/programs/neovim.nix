{ inputs, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly.packages.${pkgs.system}.default;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      gnumake
      clang
      go
      cargo
      tree-sitter
      stylua

      fd
      ripgrep
      fzf
      unzip
      wget
    ];
  };
}
