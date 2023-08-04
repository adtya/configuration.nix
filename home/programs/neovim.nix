{pkgs, ...}: {
  #xdg.desktopEntries = {
  #  "nvim".name = "Neovim wrapper";
  #  "nvim".exec = "nvim %F";
  #  "nvim".noDisplay = true;
  #};
  programs.neovim = {
    enable = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      fd
      ripgrep
      tree-sitter
      nil
    ];

    extraConfig = ''
      set autowrite
      set background=dark
      set clipboard+=unnamedplus
      set expandtab
      set laststatus=2
      set noshowmode
      set noswapfile
      set number
      set relativenumber
      set shiftwidth=2
      set signcolumn=yes
      set smartindent
      set tabstop=2
      set termguicolors
      set updatetime=100
      set wrap
      set splitright
      set splitbelow

      nmap <C-a> <cmd>bp<Return>
      nmap <C-d> <cmd>bn<Return>
      nnoremap <C-h> <cmd>noh<Return>
      nnoremap <leader>w <cmd>bdelete<CR><cmd>bnext<Return>
    '';
  };
}
