{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorscheme = "dracula";
    extraPlugins = with pkgs.vimPlugins; [
      dracula-nvim
    ];
  };
}
