{ pkgs, ... }: {
  xdg = {
    desktopEntries = {
      "nvim".name = "Neovim wrapper";
      "nvim".exec = "nvim %F";
      "nvim".noDisplay = true;
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      fd
      ripgrep
      tree-sitter

      gcc

      lua-language-server
      nil
      vscode-langservers-extracted
      nodePackages.bash-language-server

      stylua
    ];
  };
}
