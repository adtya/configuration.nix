{pkgs, ...}: {
  programs.neovim = {
    enable = true;
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
    plugins = with pkgs.vimExtraPlugins; [
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require('nvim-web-devicons').setup {
            default = true
          }
        '';
      }
      {
        plugin = dracula-nvim;
        type = "lua";
        config = ''
          require("dracula").setup({
            show_end_of_buffer = true,
            transparent_bg = true,
            italic_comment = true
          })
          vim.cmd[[colorscheme dracula]]
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          require('nvim-tree').setup {
            diagnostics = {
              enable = true
            }
          }
        '';
      }
      {
        plugin = git-blame-nvim;
        type = "lua";
        config = ''
          vim.g.gitblame_date_format = '%r'
          vim.g.gitblame_message_when_not_committed = '''
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup()
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          vim.opt.list = true
          vim.opt.listchars:append "space:⋅"
          vim.opt.listchars:append "eol:↴"
          require("indent_blankline").setup {
            show_end_of_line = true
          }
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'dracula-nvim',
              globalstatus = true
            }
          }
        '';
      }
      {
        plugin = nvim-lastplace;
        type = "lua";
        config = ''
          require('nvim-lastplace').setup {}
        '';
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require('toggleterm').setup{}
        '';
      }
      {
        plugin = nvim-treesitter-context;
        type = "lua";
        config = ''
          require('treesitter-context').setup {
            enable = true
          }
        '';
      }
      {plugin = nvim-treesitter-refactor;}
      {
        plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            bash
            dockerfile
            gitattributes
            gitcommit
            gitignore
            git_config
            git_rebase
            go
            gomod
            gosum
            ini
            json
            markdown
            markdown_inline
            nix
            toml
            yaml
          ]);
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            auto_install = false,
            highlight = true,
            refactor = {
              highlight_definitions = {
                enable = true,
                clear_on_cursor_move = false
              }
            }
          }
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require('lspconfig').bashls.setup{}
          require('lspconfig').dockerls.setup{}
          require('lspconfig').docker_compose_language_service.setup{}
          require('lspconfig').gopls.setup{}
          require('lspconfig').jsonls.setup{}
          require('lspconfig').marksman.setup{}
          require('lspconfig').nil_ls.setup{}
          require('lspconfig').rust_analyzer.setup{}
        '';
      }
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
      nnoremap <leader>w <cmd>bdelete<cmd>bnext<Return>
      nnoremap <leader>` <cmd>ToggleTerm<Return>
      nnoremap <leader>1 <cmd>NvimTreeToggle<Return>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
  };
}
