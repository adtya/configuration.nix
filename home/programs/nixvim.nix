{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    clipboard.providers.wl-copy.enable = true;
    colorscheme = "dracula";
    extraPlugins = with pkgs.vimPlugins; [
      dracula-nvim
    ];
  };
}
