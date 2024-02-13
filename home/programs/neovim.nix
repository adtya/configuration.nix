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
      nixd

      stylua
    ];
  };
}
