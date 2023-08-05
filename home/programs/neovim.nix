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
    options = {
      autowrite = true;
      background = "dark";
      clipboard = "unnamedplus";
      expandtab = true;
      laststatus = 2;
      showmode = false;
      swapfile = false;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      signcolumn = "yes";
      smartindent = true;
      tabstop = 2;
      termguicolors = true;
      updatetime = 100;
      wrap = true;
      splitright = true;
      splitbelow = true;
    };
    maps = {
      normal = {
        "<C-a>" = {
          silent = true;
          action = "<cmd>bp<Return>";
        };
        "<C-d>" = {
          silent = true;
          action = "<cmd>bn<Return>";
        };
        "<C-h>" = {
          silent = true;
          action = "<cmd>noh<Return>";
        };
        "<leader>w" = {
          action = "<cmd>bdelete<CR><cmd>bnext><Return>";
        };
      };
    };
  };
}
