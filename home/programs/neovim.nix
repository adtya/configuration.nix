{ pkgs, neovim-nightly, ... }: {
  xdg = {
    desktopEntries = {
      "nvim".name = "Neovim wrapper";
      "nvim".exec = "nvim %F";
      "nvim".noDisplay = true;
    };
  };
  programs.neovim = {
    enable = true;
    package = neovim-nightly.packages.${pkgs.system}.default;
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
