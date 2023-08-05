{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    colorscheme = "dracula";
    extraPlugins = with pkgs.vimPlugins; [
      dracula-nvim
    ];
  };
}
